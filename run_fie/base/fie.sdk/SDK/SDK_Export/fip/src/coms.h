#ifndef COMS_H_
#define COMS_H_

#define INJECTION_PREFIX_LENGTH 1
#define INJECTION_COMMAND_LENGTH 10

int get_ascii_words(char **argv);
void get_bytes(char *input_buffer, int length);
int get_command(u32 *frame_address, u32 *bit_offset, u64 *raw_command);

#endif
