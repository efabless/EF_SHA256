/*
	Copyright 2024 Efabless Corp.

	Author: Efabless Corp. (ip_admin@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

#ifndef EF_SHA256REGS_H
#define EF_SHA256REGS_H

#ifndef IO_TYPES
#define IO_TYPES
#define   __R     volatile const unsigned int
#define   __W     volatile       unsigned int
#define   __RW    volatile       unsigned int
#endif

#define EF_SHA256_STATUS_REG_READY_REG_BIT	6
#define EF_SHA256_STATUS_REG_READY_REG_MASK	0x40
#define EF_SHA256_STATUS_REG_DIGEST_VALID_REG_BIT	7
#define EF_SHA256_STATUS_REG_DIGEST_VALID_REG_MASK	0x80
#define EF_SHA256_CTRL_REG_INIT_REG_BIT	0
#define EF_SHA256_CTRL_REG_INIT_REG_MASK	0x1
#define EF_SHA256_CTRL_REG_NEXT_REG_BIT	1
#define EF_SHA256_CTRL_REG_NEXT_REG_MASK	0x2
#define EF_SHA256_CTRL_REG_MODE_REG_BIT	2
#define EF_SHA256_CTRL_REG_MODE_REG_MASK	0x4

#define EF_SHA256_VALID_FLAG	0x1
#define EF_SHA256_READY_FLAG	0x2

typedef struct _EF_SHA256_TYPE_ {
	__R 	STATUS;
	__W 	CTRL;
	__W 	BLOCK0;
	__W 	BLOCK1;
	__W 	BLOCK2;
	__W 	BLOCK3;
	__W 	BLOCK4;
	__W 	BLOCK5;
	__W 	BLOCK6;
	__W 	BLOCK7;
	__W 	BLOCK8;
	__W 	BLOCK9;
	__W 	BLOCK10;
	__W 	BLOCK11;
	__W 	BLOCK12;
	__W 	BLOCK13;
	__W 	BLOCK14;
	__W 	BLOCK15;
	__W 	DIGEST0;
	__W 	DIGEST1;
	__W 	DIGEST2;
	__W 	DIGEST3;
	__W 	DIGEST4;
	__W 	DIGEST5;
	__W 	DIGEST6;
	__W 	DIGEST7;
	__R 	reserved_0[16294];
	__RW	IM;
	__R 	MIS;
	__R 	RIS;
	__W 	IC;
	__W 	GCLK;
} EF_SHA256_TYPE;

#endif

