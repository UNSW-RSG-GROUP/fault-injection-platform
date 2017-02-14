#include <stdlib.h>
#include "xhwicap.h"
#include "xparameters.h"
#include "fault_injection.h"

XHwIcap_Config *hwicap_config_ptr;
XHwIcap *hwicap_ptr;

#define XC6VLX240T_ID 0x44250093
#define GRESTORE_COMMAND_SIZE 7

int get_block(int frame_addr) {
	return frame_addr & 0x00E00000;
}

int get_top(int frame_addr) {
	return frame_addr & 0x00100000;
}

int get_row(int frame_addr) {
	return frame_addr & 0x000F8000;
}

int get_col(int frame_addr) {
	return frame_addr & 0x00007F80;
}

int get_minor(int frame_addr) {
	return frame_addr & 0x0000007F;
}


int hwicap_init() {
	hwicap_ptr = (XHwIcap *)  malloc(sizeof(XHwIcap));
	hwicap_config_ptr = XHwIcap_LookupConfig(XPAR_AXI_HWICAP_0_DEVICE_ID);
	int ret_status = XHwIcap_CfgInitialize(hwicap_ptr, hwicap_config_ptr, XPAR_AXI_HWICAP_0_BASEADDR);
	if (ret_status != XST_SUCCESS) {
		free(hwicap_ptr);
	    return XST_FAILURE;
	}

	ret_status = XHwIcap_SelfTest(hwicap_ptr);
	if (ret_status != XST_SUCCESS) {
		free(hwicap_ptr);
	    return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int hwicap_read_frame(u32 frame_address, u32 *frame_data) {
	u32 TotalWords;

	int Status;
	// header
	u32 WriteBuffer[18] = {
			0xFFFFFFFF, // Dummy
			0xAA995566, // Sync
			0x20000000, // Noop
			0x20000000, // Noop
			0x30008001, // CMD Reg
			0x00000007, // Clear CRC
			0x20000000, // Noop
			0x20000000, // Noop
			0x30008001, // CMD Reg
			0x00000004, // RCFG (Read Config Data)
			0x20000000, // Noop
			0x20000000, // Noop
			0x20000000, // Noop
			0x30002001, // FAR Reg
			0x00000000, // Frame Addr
			0x280060A2, // Read 202 Words
			0x20000000, // Noop (Not needed i think)
			0x20000000  // Noop (Not needed i think)
	};
	// insert frame address
	WriteBuffer[14] = frame_address;
	// Write header
	Status = XHwIcap_DeviceWrite(hwicap_ptr, (u32 *)&WriteBuffer[0], 18);
	if (Status != XST_SUCCESS)  { return XST_FAILURE; }
	while (XHwIcap_IsDeviceBusy(hwicap_ptr) != FALSE);

	// Write frame data
	TotalWords = (NUMBER_OF_WORDS_PER_FRAME << 1) +1;
	Status = XHwIcap_DeviceRead(hwicap_ptr, frame_data, TotalWords);
	if (Status != XST_SUCCESS)  { return XST_FAILURE; }
	// Send Desync (i don't think we need to desync all the time)
	Status = XHwIcap_CommandDesync(hwicap_ptr);
	if (Status != XST_SUCCESS)  { return XST_FAILURE; }
	return XST_SUCCESS;
}

int hwicap_write_frame(u32 frame_address, u32 *frame_data) {
	// header
	u32 WriteBuffer[16] = {
			0xFFFFFFFF, // Dummy
			0xAA995566, // Sync
			0x20000000, // Noop
			0x20000000, // Noop
			0x30008001, // CMD Reg
			0x00000007, // Clear CRC
			0x20000000, // Noop
			0x20000000, // Noop
			0x30018001, // ID Reg
			XC6VLX240T_ID, // ID Code
			0x30002001, // FAR Reg
			0x00000000, // Frame Addr
			0x30008001, // CMD Reg
			0x00000001, // WCFG (Write Config Data)
			0x20000000, // Noop
			0x300040A2  // Write 202 Words
	};
	// insert frame address
	WriteBuffer[11] = frame_address;
	// Write header
	XHwIcap_DeviceWrite(hwicap_ptr, (u32 *)&WriteBuffer[0], 16);
	while (XHwIcap_IsDeviceBusy(hwicap_ptr) != FALSE);
	// Write Dummy Frames
	XHwIcap_DeviceWrite(hwicap_ptr, (u32 *) &frame_data[NUMBER_OF_WORDS_PER_FRAME+1],
			NUMBER_OF_WORDS_PER_FRAME);
	while (XHwIcap_IsDeviceBusy(hwicap_ptr) != FALSE);
	// Write frame data
	XHwIcap_DeviceWrite(hwicap_ptr, (u32 *) &frame_data[0],
			NUMBER_OF_WORDS_PER_FRAME+1);
	while (XHwIcap_IsDeviceBusy(hwicap_ptr) != FALSE);
	// Desync (I don't think we need to desync all the time)
	XHwIcap_CommandDesync(hwicap_ptr);
	return XST_SUCCESS;
}

int GRESTORE() {
	int Status;
	u32 FrameBuffer[GRESTORE_COMMAND_SIZE];
	u32 Index = 0;

	Xil_AssertNonvoid(hwicap_ptr != NULL);
	Xil_AssertNonvoid(hwicap_ptr->IsReady == XIL_COMPONENT_IS_READY);

	/*
	 * Create the data to be written to the ICAP.
	 */
	FrameBuffer[Index++] = XHI_DUMMY_PACKET;
	FrameBuffer[Index++] = XHI_SYNC_PACKET;
	FrameBuffer[Index++] = XHI_NOOP_PACKET;
	FrameBuffer[Index++] = (XHwIcap_Type1Write(XHI_CMD) | 1);
	FrameBuffer[Index++] = XHI_CMD_GRESTORE;
	FrameBuffer[Index++] =  XHI_DUMMY_PACKET;
	FrameBuffer[Index++] =  XHI_DUMMY_PACKET;

	/*
	 * Write the data to the FIFO and intiate the transfer of data present
	 * in the FIFO to the ICAP device.
	 */
	Status = XHwIcap_DeviceWrite(hwicap_ptr, &FrameBuffer[0], Index);
	if (Status != XST_SUCCESS)  {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

int GCAPTURE() {
	int Status;
	u32 FrameBuffer[GRESTORE_COMMAND_SIZE];
	u32 Index = 0;

	Xil_AssertNonvoid(hwicap_ptr != NULL);
	Xil_AssertNonvoid(hwicap_ptr->IsReady == XIL_COMPONENT_IS_READY);

	/*
	 * Create the data to be written to the ICAP.
	 */
	FrameBuffer[Index++] = XHI_DUMMY_PACKET;
	FrameBuffer[Index++] = XHI_SYNC_PACKET;
	FrameBuffer[Index++] = XHI_NOOP_PACKET;
	FrameBuffer[Index++] = (XHwIcap_Type1Write(XHI_CMD) | 1);
	FrameBuffer[Index++] = XHI_CMD_GCAPTURE;
	FrameBuffer[Index++] =  XHI_DUMMY_PACKET;
	FrameBuffer[Index++] =  XHI_DUMMY_PACKET;

	/*
	 * Write the data to the FIFO and intiate the transfer of data present
	 * in the FIFO to the ICAP device.
	 */
	Status = XHwIcap_DeviceWrite(hwicap_ptr, &FrameBuffer[0], Index);
	if (Status != XST_SUCCESS)  {
		return XST_FAILURE;
	}

	return XST_SUCCESS;
}

u32 get_bits(u32 offset ,u32 *frame_data) {
	u32 word_offset = offset/32;
	u32 bit_offset = offset - (word_offset*32);
	return (frame_data[NUMBER_OF_WORDS_PER_FRAME + word_offset + 1] & (1 << bit_offset)) >> bit_offset;
}

void set_bits(u32 bit, u32 offset ,u32 *frame_data) {
	u32 word_offset = offset/32;
	u32 bit_offset = offset - (word_offset*32);
	u32 frame_word = frame_data[NUMBER_OF_WORDS_PER_FRAME + word_offset + 1];
	frame_data[NUMBER_OF_WORDS_PER_FRAME + word_offset + 1] = frame_word | (bit << bit_offset);
	if (bit == 0) {
		frame_data[NUMBER_OF_WORDS_PER_FRAME + word_offset + 1] = frame_word & (~(1 << bit_offset));
	} else {
		frame_data[NUMBER_OF_WORDS_PER_FRAME + word_offset + 1] = frame_word | (1 << bit_offset);
	}
}

void xil_read_frame(u32 frame_address, u32 *frame_data) {
	XHwIcap_DeviceReadFrame(
			hwicap_ptr,
			get_top(frame_address),
			get_block(frame_address),
			get_row(frame_address),
			get_col(frame_address),
			get_minor(frame_address),
			frame_data
			);
}

void xil_write_frame(u32 frame_address, u32 *frame_data) {
	XHwIcap_DeviceWriteFrame(
			hwicap_ptr,
			get_top(frame_address),
			get_block(frame_address),
			get_row(frame_address),
			get_col(frame_address),
			get_minor(frame_address),
			frame_data
			);
}
