/*
	Copyright 2025 Efabless Corp.

	Author: Efabless Corp. (ip_admin@efabless.com)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	    www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

*/

#ifndef EF_SHA256REGS_H
#define EF_SHA256REGS_H

 
/******************************************************************************
* Includes
******************************************************************************/
#include <stdint.h>

/******************************************************************************
* Macros and Constants
******************************************************************************/

#ifndef IO_TYPES
#define IO_TYPES
#define   __R     volatile const uint32_t
#define   __W     volatile       uint32_t
#define   __RW    volatile       uint32_t
#endif

#define EF_SHA256_STATUS_REG_READY_REG_BIT	((uint32_t)6)
#define EF_SHA256_STATUS_REG_READY_REG_MASK	((uint32_t)0x40)
#define EF_SHA256_STATUS_REG_DIGEST_VALID_REG_BIT	((uint32_t)7)
#define EF_SHA256_STATUS_REG_DIGEST_VALID_REG_MASK	((uint32_t)0x80)
#define EF_SHA256_STATUS_REG_MAX_VALUE	((uint32_t)0xFF)

#define EF_SHA256_CTRL_REG_INIT_REG_BIT	((uint32_t)0)
#define EF_SHA256_CTRL_REG_INIT_REG_MASK	((uint32_t)0x1)
#define EF_SHA256_CTRL_REG_NEXT_REG_BIT	((uint32_t)1)
#define EF_SHA256_CTRL_REG_NEXT_REG_MASK	((uint32_t)0x2)
#define EF_SHA256_CTRL_REG_MODE_REG_BIT	((uint32_t)2)
#define EF_SHA256_CTRL_REG_MODE_REG_MASK	((uint32_t)0x4)
#define EF_SHA256_CTRL_REG_MAX_VALUE	((uint32_t)0x7)

#define EF_SHA256_BLOCK0_REG_BLOCK0_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK0_REG_BLOCK0_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK0_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK1_REG_BLOCK1_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK1_REG_BLOCK1_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK1_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK2_REG_BLOCK2_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK2_REG_BLOCK2_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK2_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK3_REG_BLOCK3_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK3_REG_BLOCK3_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK3_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK4_REG_BLOCK4_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK4_REG_BLOCK4_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK4_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK5_REG_BLOCK5_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK5_REG_BLOCK5_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK5_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK6_REG_BLOCK6_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK6_REG_BLOCK6_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK6_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK7_REG_BLOCK7_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK7_REG_BLOCK7_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK7_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK8_REG_BLOCK8_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK8_REG_BLOCK8_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK8_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK9_REG_BLOCK9_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK9_REG_BLOCK9_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK9_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK10_REG_BLOCK10_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK10_REG_BLOCK10_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK10_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK11_REG_BLOCK11_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK11_REG_BLOCK11_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK11_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK12_REG_BLOCK12_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK12_REG_BLOCK12_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK12_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK13_REG_BLOCK13_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK13_REG_BLOCK13_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK13_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK14_REG_BLOCK14_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK14_REG_BLOCK14_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK14_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_BLOCK15_REG_BLOCK15_BIT	((uint32_t)0)
#define EF_SHA256_BLOCK15_REG_BLOCK15_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_BLOCK15_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_DIGEST0_REG_DIGEST0_BIT	((uint32_t)0)
#define EF_SHA256_DIGEST0_REG_DIGEST0_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_DIGEST0_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_DIGEST1_REG_DIGEST1_BIT	((uint32_t)0)
#define EF_SHA256_DIGEST1_REG_DIGEST1_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_DIGEST1_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_DIGEST2_REG_DIGEST2_BIT	((uint32_t)0)
#define EF_SHA256_DIGEST2_REG_DIGEST2_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_DIGEST2_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_DIGEST3_REG_DIGEST3_BIT	((uint32_t)0)
#define EF_SHA256_DIGEST3_REG_DIGEST3_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_DIGEST3_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_DIGEST4_REG_DIGEST4_BIT	((uint32_t)0)
#define EF_SHA256_DIGEST4_REG_DIGEST4_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_DIGEST4_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_DIGEST5_REG_DIGEST5_BIT	((uint32_t)0)
#define EF_SHA256_DIGEST5_REG_DIGEST5_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_DIGEST5_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_DIGEST6_REG_DIGEST6_BIT	((uint32_t)0)
#define EF_SHA256_DIGEST6_REG_DIGEST6_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_DIGEST6_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)

#define EF_SHA256_DIGEST7_REG_DIGEST7_BIT	((uint32_t)0)
#define EF_SHA256_DIGEST7_REG_DIGEST7_MASK	((uint32_t)0xffffffff)
#define EF_SHA256_DIGEST7_REG_MAX_VALUE	((uint32_t)0xFFFFFFFF)


#define EF_SHA256_VALID_FLAG	((uint32_t)0x1)
#define EF_SHA256_READY_FLAG	((uint32_t)0x2)


          
/******************************************************************************
* Typedefs and Enums
******************************************************************************/
          
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

typedef struct _EF_SHA256_TYPE_ *EF_SHA256_TYPE_PTR;     // Pointer to the register structure

  
/******************************************************************************
* Function Prototypes
******************************************************************************/



/******************************************************************************
* External Variables
******************************************************************************/




#endif

/******************************************************************************
* End of File
******************************************************************************/
          
          
