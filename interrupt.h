#ifndef _INTERRUPT_H_INCLUDED_
#define _INTERRUPT_H_INCLUDED_

#include "intr.h"

typedef short softvec_type_t;

typedef void (*softvec_handler_t)(softvec_type_t type, unsigned long sp);

unsigned int SOFTVECS[SOFTVEC_TYPE_NUM];

#define INTR_ENABLE  asm volatile ("ei")
#define INTR_DISABLE asm volatile ("di")

/* ソフトウエア・割込みベクタの初期化 */
int softvec_init(void);

/* ソフトウエア・割込みベクタの設定 */
int softvec_setintr(softvec_type_t type, softvec_handler_t handler);

/* 共通割込みハンドラ */
void interrupt(softvec_type_t type, unsigned long sp);

#endif
