//JOEY COTTER FLOATING POINT POLYNOMIAL EVALUATOR 2016 
        .syntax     unified
        .cpu        cortex-m4
        .text
        .thumb_func
        .align       2

// float PolyEval(float x, float coef[], int32_t terms); external function prototype

        .global     PolyEval
PolyEval:
        VLDR        S1, zero    //S1 = result
        VMOV        S2, 1.0     //S2 = power
        LDR         R2, =0      //R2 = loopcount
loop:   VLDR        S3, [R0]    //S3 = current coef
        VMUL.F32    S4, S2, S3  //S4 = power*coef
        VADD.F32    S1, S1, S4  // S1 = result
        VMUL.F32    S2, S2, S0  //power = power*x
        ADD         R0, R0, 4   //moving to next element in coef[]
        ADD         R2, R2, 1   //incrementing loopcount
        CMP         R2, R1
        BLT         loop        //break when loopcount = terms
        VMOV        S0, S1
        BX          LR
        
zero:   .float      0.0

