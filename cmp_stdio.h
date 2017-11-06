#ifndef INC_CMP_STDIO_H
#define INC_CMP_STDIO_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>

#include "cmp.h"

void cmp_init_stdio( cmp_ctx_t* ctx, FILE* f );

#endif  // INC_CMP_STDIO_H
