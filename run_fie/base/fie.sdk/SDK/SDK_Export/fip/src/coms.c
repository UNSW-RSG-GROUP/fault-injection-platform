#include <stdlib.h>
#include <string.h>
#include "xuartlite_l.h"
#include "xparameters.h"
#include "coms.h"

#define COMMAND_FRAME_ADDRESS_MASK 0x1FFFFFF000
#define COMMAND_BIT_OFFSET_MASK 0x0000000FFF

int get_ascii_line(char *input_buffer) {
	char input_char;
	input_char = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR);
	int i = 0;
	while(input_char != '\n') {
		if (input_char >= 32 && input_char <=126) {
			if(i < 127) {
				input_buffer[i] = input_char;
				i++;
			}
		}
		input_char = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR);
	}
	input_buffer[i] = '\0';
	return i;
}

int get_ascii_words(char **argv) {
	char input_buffer[128];
	get_ascii_line(input_buffer);

	int argc = 0;

	char *part;
	part = strtok (input_buffer," ");
	while (part != NULL) {
		argv[argc] = malloc(strlen(part)*sizeof(char));
		strcpy(argv[argc], part);
		argc++;
		part = strtok (NULL, " ");
	}
	return argc;
}

void get_bytes(char *input_buffer, int length) {
	int i;
	for (i = 0; i < length; i++) {
		input_buffer[i] = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR);
	}
}

int get_command(u32 *frame_address, u32 *bit_offset, u64 *raw_command) {
	char input_buffer[INJECTION_PREFIX_LENGTH+INJECTION_COMMAND_LENGTH+1];
	input_buffer[INJECTION_PREFIX_LENGTH+INJECTION_COMMAND_LENGTH] = '\0';

	input_buffer[0] = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR);
	if (input_buffer[0] != 'N') {
		if (input_buffer[0] == 'S') {
			xil_printf("STOPPING\r\n");
			*raw_command = 'S';
			return 0;
		} else {
			//xil_printf("%c\r\n", input_buffer[0]);
			//xil_printf("UNKOWN COMMAND\r\n");
		}
		return -1;
	}

	int i;
	for (i = 1; i < INJECTION_PREFIX_LENGTH+INJECTION_COMMAND_LENGTH; i++) {
		input_buffer[i] = XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR);
	}

	char command[INJECTION_COMMAND_LENGTH+1];
	command[INJECTION_COMMAND_LENGTH] = '\0';
	for (i = 0; i < INJECTION_COMMAND_LENGTH; i++) {
		command[i] = input_buffer[INJECTION_PREFIX_LENGTH+i];
	}


	if (input_buffer[0] == 'N') {
		char command_bit_offset[4];
		char command_frame_address[9];
		command_bit_offset[0] = command[7];
		command_bit_offset[1] = command[8];
		command_bit_offset[2] = command[9];
		command_bit_offset[3] = '\0';
		command_frame_address[0] = '0';
		command_frame_address[1] = command[0];
		command_frame_address[2] = command[1];
		command_frame_address[3] = command[2];
		command_frame_address[4] = command[3];
		command_frame_address[5] = command[4];
		command_frame_address[6] = command[5];
		command_frame_address[7] = command[6];
		command_frame_address[8] = '\0';
		*frame_address = (unsigned int) strtoul(command_frame_address, NULL, 16);
		*bit_offset = (unsigned int) strtoul(command_bit_offset, NULL, 16);
		*raw_command = 0;
	} else {
		return -1;
	}

	return 0;
}

