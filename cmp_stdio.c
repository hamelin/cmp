#include "cmp_stdio.h"

bool cmp_stdio_read(cmp_ctx_t* ctx, void* data, size_t limit) {
  return (limit * sizeof(uint8_t)) == fread(data, sizeof(uint8_t), limit, (FILE*)ctx->buf);
}

bool cmp_stdio_skip(cmp_ctx_t* ctx, size_t count) {
  return fseek((FILE*)ctx->buf, count, SEEK_CUR);
}

size_t cmp_stdio_write(cmp_ctx_t* ctx, const void* data, size_t count)
{
  return fwrite(data, sizeof(uint8_t), count, (FILE*)ctx->buf);
}

void cmp_init_stdio(cmp_ctx_t* ctx, FILE* file) {
  cmp_init(ctx, file, cmp_stdio_read, cmp_stdio_skip, cmp_stdio_write);
}


// EOF
