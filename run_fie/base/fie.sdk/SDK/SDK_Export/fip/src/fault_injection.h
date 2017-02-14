#define NUMBER_OF_WORDS_PER_FRAME 81

int hwicap_init();

int hwicap_read_frame(u32 frame_address, u32 *frame_data);
int hwicap_write_frame(u32 frame_address, u32 *frame_data);

void xil_read_frame(u32 frame_address, u32 *frame_data);
void xil_write_frame(u32 frame_address, u32 *frame_data);

int GRESTORE();
int GCAPTURE();

u32 get_bits(u32 offset ,u32 *frame_data);
void set_bits(u32 bit, u32 offset ,u32 *frame_data);
