# arm_bootloader
> Soc baisc
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

