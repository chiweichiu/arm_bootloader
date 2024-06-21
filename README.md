# arm_bootloader
> Soc basic
![alt soc_basic](https://github.com/chiweichiu/arm_bootloader/blob/main/utils/soc_basic.jpg) <br>
- arm需要透過dram controller來控制外部sdram來了解其狀態
- 資料放nor flash因為不需要init就可以access data, boot code放這裡
- ISA : cpu硬體的抽象, 包含(1)ALU (2)load/store stack push/pop (3)control flow
> bootloader工作
- 關閉中斷
- 關閉watch dog
- 驅動SDRAM
- copy data section(to DRAM), init bss
- stack setup
- init nessary 周邊IO device
- 執行程式 可能是(1) diag (2) update flash (3) start kernel
> ISA
- Raspi 3 = cortex-A53 = arm v8
- arm v8 support 64 bit
> Processor Core
- 主要(1) datapath (register ALU) (2) decoder (instruction from RAM)
> ARM
- 2 state (1) arm state (32bit) (2) thumb state (16bit) (提高程式密度) (3) BX指令切換
![alt arm_processor_mode](https://github.com/chiweichiu/arm_bootloader/blob/main/utils/arm_processor_mode.jpg) <br>
- 透過exception進入特權模式, 有些指令只有在特權模式才能執行
- system call(如fork)即是user mode切到SVC mode
- 不同mode看到不同register bank 
![alt register_bank](https://github.com/chiweichiu/arm_bootloader/blob/main/utils/register_bank.jpg) <br>
- 31 general porpose registers + 6 stats registers
- r14 link register, 紀錄function call跳躍時要返回的指令位址
- r15 PC : 所有模式共用
- thumb state : 沒有r8-r12
- PSR : ALU運算後的程式狀態
![alt psr](https://github.com/chiweichiu/arm_bootloader/blob/main/utils/psr.jpg) <br>
- condition code flags = N(<0)Z(=0)C(進位)V(overflow)
- bit7 disable IRQ
- bit6 disable FIQ
- 切換mode會將CPSR備份到S(save)PSR (也要備份藍色r0-r7部分)
![alt condition_flag](https://github.com/chiweichiu/arm_bootloader/blob/main/utils/condtion_flag.jpg) <br>
- suffix : ADD r0,r1,r2 -> ADDNE ADD r0,r1,r2 (depend on前一個指令運算結果)(指令密度更高)
> Arm tutorial
- [arm_tutorial/BL/ex_1.s](https://github.com/chiweichiu/arm_bootloader/blob/main/arm_tutoial/BL/ex_1.s)
- BL: branch with Link : 將返回address存到link register r14
![alt bl_example](https://github.com/chiweichiu/arm_bootloader/blob/main/utils/bl_example.jpg) <br>  
- [arm_tutorial/ALMCops/ex_2.s](https://github.com/chiweichiu/arm_bootloader/blob/main/arm_tutoial/ALMCops/ex_2.s)
- LDR r0,=0xff00ff00 => 將r0設定為0xff00ff00, 若沒有=表示要從記憶體位址0xff00ff00撈資料給r0
- [arm_tutorial/STMFD/ex_2.s](https://github.com/chiweichiu/arm_bootloader/blob/main/arm_tutoial/STMFD/ex_2.s)
![alt stmfd](https://github.com/chiweichiu/arm_bootloader/blob/main/utils/stmfd.jpg) <br>  
- r13 stack pointer(sp)位址設定為0x100000
- 跳到func1執行STMFD r13!,[r0-r3,r14] 將r0-r3及r14(返回位址)備份到memory sp指定位址
- sp是往底位址放且放置順序為r14 r3 r2 r1 r0 所以r14內容被放到0xFFFC
- 因為有! 所以r13會變 變成備份r0內容的地址 所以r13=0xFFEC
- 接著故意把r0-r3改成0x10-0x40 呼叫func2 會備份func1的0x10-0x40到memory
- 最後執行LDMFD 會pop 0x1-0x4以及返回地址到原start的樣子






