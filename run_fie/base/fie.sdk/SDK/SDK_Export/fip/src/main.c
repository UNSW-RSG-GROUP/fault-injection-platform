#include "xil_printf.h"
#include "xgpio.h"
#include "xparameters.h"
#include "fault_injection.h"
#include "coms.h"
#include "xtmrctr.h"
#include "xuartlite_l.h"

XGpio gpio_0;
XGpio gpio_1;
XGpio gpio_2;
XGpio gpio_3;
XTmrCtr tmr_0;

void init_gpio();
void set_start();
void set_rst_DUT();
unsigned int get_finish();
unsigned int get_result();
void init_timer();
unsigned int get_time_in_us();
void set_rst_FSM();

#define ROUND_UP(N, S) ((((N) + (S) - 1) / (S)) * (S))

int inject(u32 frame_address, u32 bit_offset, u32 *frame_buffer) {
	// Read the frame we want to inject to
	if (hwicap_read_frame(frame_address, frame_buffer) != XST_SUCCESS) {
		return XST_FAILURE;
	}
	//xil_read_frame(frame_address, frame_buffer);

	// Flip bit (can be more efficient)
	if (get_bits(bit_offset, frame_buffer) == 0) {
		set_bits(1, bit_offset, frame_buffer);
	} else {
		set_bits(0, bit_offset, frame_buffer);
	}

	// Write the frame back
	if (hwicap_write_frame(frame_address, frame_buffer) != XST_SUCCESS) {
		return XST_FAILURE;
	}
	//xil_write_frame(frame_address, frame_buffer);

	return XST_SUCCESS;
}

int deinject(u32 frame_address, u32 bit_offset, u32 *frame_buffer) {
	// Flip the bit again (should actually just store the original word)
	if (get_bits(bit_offset, frame_buffer) == 0) {
		set_bits(1, bit_offset, frame_buffer);
	} else {
		set_bits(0, bit_offset, frame_buffer);
	}
	// Write it back
	if (hwicap_write_frame(frame_address, frame_buffer) != XST_SUCCESS) {
		return XST_FAILURE;
	}

	//xil_write_frame(frame_address, frame_buffer);
	return XST_SUCCESS;
}

int main() {
	char startup[1];
	get_bytes(startup, 1);
	while (startup[0] != 'I') {
		get_bytes(startup, 1);
	}
	u32 expected = 0;
	u32 timeout = 0;

	int i;
	for (i = 3; i >= 0; i--) {
		expected |=  (u32) XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR) << (8*i);
	}
	for (i = 3; i >= 0; i--) {
		timeout |=  (u32) XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR) << (8*i);
	}

	xil_printf("\r\n--[Fault Injection Platform]--\r\n");
	xil_printf("Initializing GPIO...\r\n");
	init_gpio();
	xil_printf("Done Initializing GPIO...\r\n");
	xil_printf("Initializing HWICAP...\r\n");
	hwicap_init();
	xil_printf("Done Initializing HWICAP...\r\n");
	xil_printf("Expected: %d\r\n", expected);
	xil_printf("Timeout: %d\r\n", timeout);
	init_timer();
	set_rst_DUT();
	set_start();
	while (get_finish() == 0) {
	}
	u32 result = get_result();
	if (result == expected) {
		xil_printf("DUT is functional. Result = %d\r\n", result);
	} else {
		xil_printf("DUT is not functional. Result = %d\r\n", result);
		return XST_FAILURE;
	}
	xil_printf("X");

    get_bytes(startup, 1);
	while (startup[0] != 'I') {
		get_bytes(startup, 1);
	}

	u32 frame_address;
	u32 bit_offset;
	u64 raw_command;

	u32 frame_buffer[NUMBER_OF_WORDS_PER_FRAME*2 + 1];
	while(1) {

		get_command(&frame_address, &bit_offset, &raw_command);
		set_rst_DUT(); // reset the circuit
		// Inject Fault
		inject(frame_address, bit_offset, frame_buffer); // inject
		set_start(); // run
		XTmrCtr_Start(&tmr_0, 0);
		//int timed_out_0 = 0;
		while (get_finish() == 0) {
			if (get_time_in_us() > timeout) {
				//timed_out_0 = 1;
				break;
			}
		}
		unsigned int result_0 = get_result(); // RESULT_0


		// Deinject Fault
		deinject(frame_address, bit_offset, frame_buffer); // fix error
		set_start(); // run
		XTmrCtr_Start(&tmr_0, 0);
		//int timed_out_1 = 0;
		while (get_finish() == 0) {
			if (get_time_in_us() > timeout) {
				//timed_out_1 = 1;
				break;
			}
		}
		unsigned int result_1 = get_result(); // RESULT_1


		set_rst_DUT(); // reset the circuit
		set_start(); // run
		XTmrCtr_Start(&tmr_0, 0);
		//int timed_out_2 = 0;
		while (get_finish() == 0) {
			if (get_time_in_us() > timeout) {
				//timed_out_2 = 1;
				break;
			}
		}
		unsigned int result_2 = get_result(); // RESULT_2

		// Return result
		if (result_0 != expected) {
			xil_printf("Z");
		}

		if (result_1 != expected) {
			xil_printf("K"); // feedback error or unrecoverable
		}

		if (result_2 != expected) {
			xil_printf("Y"); // unrecoverable error
		}

		xil_printf("X");

/*		// Return result
		if (timed_out_0 == 1 && timed_out_1 == 0 && result_1 == EXPECTED) {
			xil_printf("Z");
			xil_printf("X");
		} else if (timed_out_0 == 1 && timed_out_1 == 1) {
			xil_printf("Y");
		} else if (timed_out_0 == 0 && timed_out_1 == 1) {
			xil_printf("Y");
		} else if (result_0 == EXPECTED && result_1 == EXPECTED) {
			xil_printf("X");
		} else if (result_0 != EXPECTED && result_1 == EXPECTED) {
			xil_printf("Z");
			xil_printf("X");
		} else if (result_0 == EXPECTED && result_1 != EXPECTED) {
			xil_printf("Y");
		} else {
			xil_printf("Y");
		}*/
	}
	return 0;
}

void init_gpio() {
	// Init GPIO_0, result_dut
	XGpio_Initialize(&gpio_0, XPAR_AXI_GPIO_0_DEVICE_ID);
	XGpio_Config* gpio_0_cfg_ptr = XGpio_LookupConfig(
			XPAR_AXI_GPIO_0_DEVICE_ID);
	XGpio_CfgInitialize(&gpio_0, gpio_0_cfg_ptr, XPAR_AXI_GPIO_0_BASEADDR);
	XGpio_SetDataDirection(&gpio_0, 1, 0xFFFFFFFF);

	// Init GPIO_1, ctrl_input and ctrl_output
	XGpio_Initialize(&gpio_1, XPAR_AXI_GPIO_1_DEVICE_ID);
	XGpio_Config* gpio_1_cfg_ptr = XGpio_LookupConfig(
			XPAR_AXI_GPIO_1_DEVICE_ID);
	XGpio_CfgInitialize(&gpio_1, gpio_1_cfg_ptr, XPAR_AXI_GPIO_1_BASEADDR);
	XGpio_SetDataDirection(&gpio_1, 1, 0xFFFFFFFF);
	XGpio_SetDataDirection(&gpio_1, 2, 0x00000000);

	// Init GPIO_2, ctrl_output
	XGpio_Initialize(&gpio_2, XPAR_AXI_GPIO_2_DEVICE_ID);
	XGpio_Config* gpio_2_cfg_ptr = XGpio_LookupConfig(
			XPAR_AXI_GPIO_2_DEVICE_ID);
	XGpio_CfgInitialize(&gpio_2, gpio_2_cfg_ptr, XPAR_AXI_GPIO_2_BASEADDR);
	XGpio_SetDataDirection(&gpio_2, 1, 0x00000000);

	// Init GPIO_2, ctrl_output
	XGpio_Initialize(&gpio_3, XPAR_AXI_GPIO_3_DEVICE_ID);
	XGpio_Config* gpio_3_cfg_ptr = XGpio_LookupConfig(
			XPAR_AXI_GPIO_3_DEVICE_ID);
	XGpio_CfgInitialize(&gpio_3, gpio_3_cfg_ptr, XPAR_AXI_GPIO_3_BASEADDR);
	XGpio_SetDataDirection(&gpio_3, 1, 0x00000000);
}


void init_timer() {
	XTmrCtr_Initialize(&tmr_0, XPAR_AXI_TIMER_0_DEVICE_ID);
	XTmrCtr_SetResetValue(&tmr_0, 0, 0);
}

unsigned int get_time_in_us() {
	unsigned int cc = XTmrCtr_GetValue(&tmr_0, 0);
	return cc/(XPAR_AXI_TIMER_0_CLOCK_FREQ_HZ/1000000);
}

unsigned int get_result() {
	return XGpio_DiscreteRead(&gpio_0, 1);
}

void set_start() {
	set_rst_FSM();
	XGpio_DiscreteWrite(&gpio_1, 2, 0xFFFFFFFF);
	XGpio_DiscreteWrite(&gpio_1, 2, 0);
}

void set_rst_DUT() {

	XGpio_DiscreteWrite(&gpio_2, 1, 0xFFFFFFFF);
/*	u32 i = 100;
	do {
		i--;
	} while (i > 0);*/

	XGpio_DiscreteWrite(&gpio_2, 1, 0);
}

void set_rst_FSM() {

	XGpio_DiscreteWrite(&gpio_3, 1, 0xFFFFFFFF);
/*	u32 i = 100;
	do {
		i--;
	} while (i > 0);*/

	XGpio_DiscreteWrite(&gpio_3, 1, 0);
}

unsigned int get_finish() {
	unsigned int ctrl_input = XGpio_DiscreteRead(&gpio_1, 1);
	return ctrl_input & 0x00000001;
}
