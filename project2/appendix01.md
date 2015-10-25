# 程序源代码

## 循环校验头文件

```c
/////////////////////////////////////////////////////////////////////
///////
//Name:      test.h
//Purpose:   calculate the value of Cyclic Redundancy Check(CRC)
//Author:    chen congmei
//Created:   28/05/2009  09:06:12
//Copyright: chen congmei
/////////////////////////////////////////////////////////////////////
///////
/*========================= 
计算子程序  CrC
==========================*/ 
unsigned  short int CrcCal(unsigned short int Data, unsigned short int
    GenPoly, unsigned short int CrcData) 
{ 
     unsigned short int TmpI; 
     Data*=2; 
     for(TmpI=8;TmpI>0;TmpI--) 
     { 
          Data=Data/2; 
          if((Data ^ CrcData)&1)CrcData=(CrcData/2)^ GenPoly; 
          else CrcData/=2; 
         
     } 
     return CrcData; 
}
```

## 数据变换头文件

```c
/////////////////////////////////////////////////////////////////////
///////
//Name:      convert.h
//Purpose:   convert one data type to another data type  
//Author:    chen congmei
//Created:   28/05/2009  09:06:12
//Copyright: chen congmei
/////////////////////////////////////////////////////////////////////
///////
/*======================== 
        公共变量 
==========================*/ 
union 
    { 
        unsigned char uc[4]; 
        int           lda; 
        unsigned int  ul; 
        float         fda; 
    }un_4b; 
 
union 
    { 
        unsigned char uc[2]; 
        short int     ida; 
        unsigned short int  ui; 
    }un_2b; 
     
int              lda; 
short int        ida; 
float             real; 
unsigned char     uca[4]; 
unsigned char     ucb[2]; 
   
/*================================================= 
浮点数据转换为字节数据 
入口数据：real 放入要转换的浮点数据; 
出口数据：转换的四字节数据在 uca[]中  顺序是从低(uca[0])到高(uca[3]) 
 
real=1.0;转换为字节 uca[0]-uca[3]=0,0,0x80,0x3f  
===================================================*/ 
void  FtoB(void) 
{ 
    un_4b.fda=real; 
    uca[0]=un_4b.uc[3]; 
    uca[1]=un_4b.uc[2]; 
    uca[2]=un_4b.uc[1]; 
    uca[3]=un_4b.uc[0]; 
 
} 
 
/*================================================= 
字节数据转换为浮点数据 
入口数据：要转换的四字节数据在 uca[]中  顺序是从低(uca[0])到高(uca[3]) 
出口数据：real 存放的为已转换的浮点数据; 
 
数据 uca[0]-uca[3]=0,0,0x80,0x3f转换为浮点 real=1.0  
===================================================*/ 
void BtoF(void) 
{ 
    un_4b.uc[0]=uca[3]; 
    un_4b.uc[1]=uca[2]; 
    un_4b.uc[2]=uca[1]; 
    un_4b.uc[3]=uca[0]; 
    real=un_4b.fda; 
} 
 
/*=========================================================== 
长整形数据转换为字节数据 
入口数据：要转换的长整形放在 lda中 
出口数据：转换完的四字节数据在 uca[]中  顺序是从高(uca[0])到第(uca[3])  
 
长整数据 lda=1000 转换的字节数据 uca[0]-uca[3]=0xe8,0x03,0,0 
============================================================*/ 
void LtoB(void) 
{ 
    un_4b.lda=lda; 
    uca[0]=un_4b.uc[0]; 
    uca[1]=un_4b.uc[1]; 
    uca[2]=un_4b.uc[2]; 
    uca[3]=un_4b.uc[3]; 
     
} 
 
/*=========================================================== 
字节数据换为长整形数据转 
入口数据：转换完的四字节数据在 uca[]中  顺序是从高(uca[0])到第(uca[3])  
出口数据：转换完毕的长整形放在 lda中 
 字节数据 uca[0]-uca[3]=0xe8,0x03,0,0 转换的长整形数 lda=1000 
============================================================*/ 
void BtoL(void) 
{ 
    un_4b.uc[0]=uca[3]; 
    un_4b.uc[1]=uca[2]; 
    un_4b.uc[2]=uca[1]; 
    un_4b.uc[3]=uca[0]; 
    lda=un_4b.lda; 
} 
 
/*=========================================================== 
整形数据换为字节数据 
入口数据：要转换的整形放在 ida中 
出口数据：转换完的２字节数据在 ucb[]中  顺序是从高(ucb[0])到第(ucb[1])  
 
要转换的整形数据 ida=1000,转换的字节数据 ucb[0]-ucb[1]=0xe8,0x03  
============================================================*/ 
void ItoB(void) 
{ 
    un_2b.ida=ida; 
    ucb[0]=un_2b.uc[1]; 
    ucb[1]=un_2b.uc[0]; 
 
} 
 
/*========================================================== 
字节数据转换为整形数据 
入口数据：要转换的２字节数据在 ucb[]中  顺序是从高(ucb[0])到第(ucb[1])  
出口数据：转换完毕的整形放在 ida中 
 字节数据 ucb[0]-ucb[1]=0xe8,0x03 转换的整形数 ida=1000 
============================================================*/ 
void BtoI(void) 
{ 
    un_2b.uc[0]=ucb[1]; 
    un_2b.uc[1]=ucb[0]; 
    ida=un_2b.ida; 
} 
```

## 主程序

```c
/////////////////////////////////////////////////////////////////////
///////
//Name:      comm.c
//Purpose:   communicate with ZW1402
//Author:    chen congmei
//Created:   28/05/2009  09:06:12
//Copyright: chen congmei
/////////////////////////////////////////////////////////////////////
///////

#include <ansi_c.h>
#include <stdlib.h>
#include <windows.h>
#include "asynctmr.h"
#include <formatio.h>
#include <rs232.h>
#include <cvirte.h>     
#include <utility.h>
#include <userint.h>
#include <commdlg.h>
#include "comm.h"
#include "convert.h" 
#include "test.h"
#include "ExcelReport.h"
#include "excel2000.h"

static CAObjHandle applicationHandle = 0;
static CAObjHandle workbookHandle = 0;
static CAObjHandle worksheetHandle = 0;
static CAObjHandle chartHandle = 0;
static int running = 0;
static int copytableDone = 0;
static int PlotType = ExRConst_GalleryArea;
static int panel_handle;
static int config_handle;
static int file_handle;

unsigned short int testout;
unsigned short int testin;
int i,j;
char devicename[30];
static int comport = 4,
             baudrate = 9600,
             status = 1;
static float data;
int portindex, RS232Error, config_flag, file_flag, addr,
     rate, baud, comm, flag,    flag1, flag2, flag3;
        
float up, low, ir, upr, lowr, irr;
int numberOfRows, year, month, day;
Point cellp;
char date[11];

void DisplayRS232Error (void);
void SetConfigParms (void);
void GetConfigParms (void);
void SetFloat (void);
void SetUp (void);
void SetLow (void);
void SetIr (void);
void SetDevice (void);
void GetFloat (void);
void GetInt (void);
void Communi (void);
void RdData (void);  


int main (int argc, char *argv[])
{
    if (InitCVIRTE (0, argv, 0) == 0)
        return -1;
    if ((panel_handle = LoadPanel (0, "comm.uir", PANEL)) < 0)
        return -1;
    
    DisplayPanel (panel_handle);
    RunUserInterface ();
    DiscardPanel (panel_handle);
    CloseCVIRTE ();
    return 0;
}

void SetConfigParms (void)
{   

    SetCtrlVal (config_handle, CONFIG_COMPORT, comport); 
    SetCtrlVal (config_handle, CONFIG_BAUDRATE, baudrate);
    SetCtrlVal (config_handle, CONFIG_UP, up);
    SetCtrlVal (config_handle, CONFIG_LOW, low);
    SetCtrlVal (config_handle, CONFIG_IR, ir);
    SetCtrlIndex (config_handle, CONFIG_COMPORT, portindex);
}

// Get the port configuration parameters.                                    
void GetConfigParms (void)
{       
    GetCtrlVal (config_handle, CONFIG_COMPORT, &comport); 
    GetCtrlVal (config_handle, CONFIG_BAUDRATE, &baudrate);
    GetCtrlVal (config_handle, CONFIG_UP, &up);
    GetCtrlVal (config_handle, CONFIG_LOW, &low);
    GetCtrlVal (config_handle, CONFIG_IR, &ir);
    GetCtrlIndex (config_handle, CONFIG_COMPORT, &portindex);
    #ifdef _NI_unix_
        devicename[0]=0;
    #else
       GetLabelFromIndex (config_handle, CONFIG_COMPORT, portindex,
                        devicename);
   #endif                    
}

//open the configuration panel.                                            
int CVICALLBACK Estab (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_COMMIT:
              config_handle = LoadPanel (panel_handle, "comm.uir", CONFIG);
              InstallPopup (config_handle);
              if (config_flag)    /* Configuration done at least once.*/
                  SetConfigParms ();
              else                /* 1st time.*/
                  config_flag = 1;
              break;
    }
    return 0;
}

//close the configuration panel.                                            
int CVICALLBACK Over (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_COMMIT:
            GetConfigParms ();
            DisableBreakOnLibraryErrors (); 
       RS232Error = OpenComConfig (comport, devicename, baudrate, 0,8,
                    1, 512, 512);
            EnableBreakOnLibraryErrors ();
            if (RS232Error == 0)
            {
                 SetDevice ();
            }
            else
                 DisplayRS232Error ();
            
            DiscardPanel (config_handle);
            break;
    }
    return 0;
}

void SetUp (void)
{
    unsigned char out[13] = {1,0x10,0,0,0,2,4};                          
    unsigned char in[8];
    out[2] = 0x19;
    out[3] = 0;
    real = up;
    FtoB();                                                       
    out[7]=uca[0];                                             
    out[8]=uca[1]; 
    out[9] = uca[2];
    out[10] = uca[3];
    testout = 0xffff;                                               
    for(i = 0;i < 11;i = i + 1)testout = CrcCal(out[i],0xa001,testout);   
    out[11] = testout%256;                                        
    out[12] = testout/256;                                        
    FlushInQ (comport);                                           
    ComWrt (comport, out, 13);                                  
    ComRd (comport, in, 8);
    if(in[1] == 0x10) flag1 = 0;
    if(in[1] == 0x90) flag1 = 1;
}

void SetLow (void)
{
    unsigned char out[13] = {1,0x10,0,0,0,2,4};                          
    unsigned char in[8];
    out[2] = 0x19;
    out[3] = 2;
    real = low;
    FtoB();                                                       
    out[7]=uca[0];                                             
    out[8]=uca[1]; 
    out[9] = uca[2];
    out[10] = uca[3];
    testout = 0xffff;                                               
    for(i = 0;i < 11;i = i + 1)testout = CrcCal(out[i],0xa001,testout);   
    out[11] = testout%256;                                        
    out[12] = testout/256;                                        
    FlushInQ (comport);                                           
    ComWrt (comport, out, 13);                                  
    ComRd (comport, in, 8);
    if(in[1] == 0x10) flag2 = 0;
    if(in[1] == 0x90) flag2 = 1;
}

void SetIr (void)
{
    unsigned char out[13] = {1,0x10,0,0,0,2,4};                          
    unsigned char in[8];
    out[2] = 0x1f;
    out[3] = 2;
    real=ir;
    FtoB();                                                       
    out[7]=uca[0];                                             
    out[8]=uca[1]; 
    out[9] = uca[2];
    out[10] = uca[3];
    testout = 0xffff;                                               
    for(i = 0;i < 11;i = i + 1)testout = CrcCal(out[i],0xa001,testout);   
    out[11] = testout%256;                                        
    out[12] = testout/256;                                        
    FlushInQ (comport);                                           
    ComWrt (comport, out, 13);                                  
    ComRd (comport, in, 8);
    if(in[1] == 0x10) flag3 = 0;
    if(in[1] == 0x90) flag3 = 1;
}

void SetDevice (void)
{
    SetUp ();
    SetLow ();
    SetIr ();
    flag = flag1 + flag2 + flag3;
    if(flag1 == 1)SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：上限
            ：          CRC校验错！");
    if(flag2 == 1)SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：
            下限：    CRC校验错！");
    if(flag3 == 1)SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：
            CT：CRC校验错！");
    if(flag == 0)SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：设置成
            功！");
}


//communicate with the device.
void Communi (void)
{
    unsigned char outbuf[8] = {1,3,0,0,0,0};
    unsigned char inbuf[9];
    outbuf[2] = 0x10;
    outbuf[3] = 0x02;
    outbuf [5] = 2;
    testout=0xffff; 
    for(i = 0;i < 6;i = i+1)testout = CrcCal(outbuf[i],0xa001,testout);
    outbuf[6] = testout%256;
    outbuf[7] = testout/256;
    FlushInQ (comport);
    ComWrt (comport, outbuf, 8);
    ComRd (comport, inbuf, 9);
    if(inbuf[1] == 3)
    {        
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：成功！");
        uca[0] = inbuf[3];
        uca[1] = inbuf[4];
        uca[2] = inbuf[5];
        uca[3] = inbuf[6];
        BtoF();
    }
    if(inbuf[1] == 0x83)
    {
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：电流：
                    通讯超时！");
    }
    data = real;
    SetCtrlVal (panel_handle, PANEL_DATA, data); 
}

void GetIr (void)
{
    unsigned char outbuf[8] = {1,3,0,0,0,0};
    unsigned char inbuf[9];
    outbuf[2] = 0x1f;
    outbuf[3] = 0x02;
    outbuf [5] = 2;
    testout=0xffff; 
    for(i = 0;i < 6;i = i+1)testout = CrcCal(outbuf[i],0xa001,testout);
    outbuf[6] = testout%256;
    outbuf[7] = testout/256;
    FlushInQ (comport);
    ComWrt (comport, outbuf, 8);
    ComRd (comport, inbuf, 9);
    if(inbuf[1] == 3)
    {        
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：成功！");
        uca[0] = inbuf[3];
        uca[1] = inbuf[4];
        uca[2] = inbuf[5];
        uca[3] = inbuf[6];
        BtoF();
    }
    if(inbuf[1] == 0x83)
    {
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：      CT：
                    通讯超时！");
        
    }
    irr = real;
    SetCtrlVal (panel_handle, PANEL_IRR, irr);
}

void GetUp (void)
{
    unsigned char outbuf[8] = {1,3,0,0,0,0};
    unsigned char inbuf[9];
    outbuf[2] = 0x19;
    outbuf[3] = 2;
    outbuf [5] = 2;
    testout=0xffff; 
    for(i = 0;i < 6;i = i+1)testout = CrcCal(outbuf[i],0xa001,testout);
    outbuf[6] = testout%256;
    outbuf[7] = testout/256;
    FlushInQ (comport);
    ComWrt (comport, outbuf, 8);
    ComRd (comport, inbuf, 9);
    if(inbuf[1] == 3)
    {        
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：成功！");
        uca[0] = inbuf[3];
        uca[1] = inbuf[4];
        uca[2] = inbuf[5];
        uca[3] = inbuf[6];
        BtoF();
    }
    if(inbuf[1] == 0x83)
    {
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：
                    下限：通讯超时！");
         
    }
    lowr = real;
    SetCtrlVal (panel_handle, PANEL_LOWR, lowr);
}

void GetLow (void)
{
    unsigned char outbuf[8] = {1,3,0,0,0,0};
    unsigned char inbuf[9];
    outbuf[2] = 0x19;
    outbuf[3] = 0;
    outbuf [5] = 2;
    testout=0xffff; 
    for(i = 0;i < 6;i = i+1)testout = CrcCal(outbuf[i],0xa001,testout);
    outbuf[6] = testout%256;
    outbuf[7] = testout/256;
    FlushInQ (comport);
    ComWrt (comport, outbuf, 8);
    ComRd (comport, inbuf, 9);
    if(inbuf[1] == 3)
    {        
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：成功！");
        uca[0] = inbuf[3];
        uca[1] = inbuf[4];
        uca[2] = inbuf[5];
        uca[3] = inbuf[6];
        BtoF();
    }
    if(inbuf[1] == 0x83)
    {
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：
                    上限：      通讯超时！");
                 
    }
    
    upr = real;
    SetCtrlVal (panel_handle, PANEL_UPR, upr);
}

void GetAddr (void)
{
    unsigned char outbuf[8] = {1,3,0,0,0,0};
    unsigned char inbuf[9];
    outbuf[2] = 0x1f;
    outbuf[3] = 0x51;
    outbuf[5] = 1;
    testout = 0xffff; 
    for(i=0;i<6;i=i+1)testout=CrcCal(outbuf[i],0xa001,testout);
    outbuf[6]=testout%256;
    outbuf[7]=testout/256;            
    FlushInQ (comport);
    ComWrt (comport, outbuf, 8);
    ComRd (comport,inbuf,7);
    if(inbuf[1] == 3)
    {        
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：成功！");
        ucb[0]=inbuf[3];
        ucb[1]=inbuf[4];
        BtoI();

    }
    if(inbuf[1] == 0x83)
    {
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：          地址
                ：                   通讯超时！");
                
    }
    addr = ida;
    SetCtrlVal (panel_handle, PANEL_ADDR, addr);
}

void GetBaud (void)
{
    unsigned char outbuf[8] = {1,3,0,0,0,0};
    unsigned char inbuf[9];
    outbuf[2] = 0x1f;
    outbuf[3] = 0x52;
    outbuf[5] = 1;
    testout = 0xffff; 
    for(i=0;i<6;i=i+1)testout=CrcCal(outbuf[i],0xa001,testout);
    outbuf[6]=testout%256;
    outbuf[7]=testout/256;            
    FlushInQ (comport);
    ComWrt (comport, outbuf, 8);
    ComRd (comport,inbuf,7);
    if(inbuf[1] == 3)
    {        
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：成功！");
        ucb[0]=inbuf[3];
        ucb[1]=inbuf[4];
        BtoI();

    }
    if(inbuf[1] == 0x83)
    {
        SetCtrlVal (panel_handle, PANEL_TEXT, "通讯状态：
                    速率：             通讯超时！");        
    }
    
    switch (ida)
    {
        case 0: rate = 300;break;
        case 1: rate = 600;break;
        case 2: rate = 1200;break;
        case 3: rate = 2400;break;
        case 4: rate = 4800;break;
        case 5: rate = 9600;break;
    }
    SetCtrlVal (panel_handle, PANEL_RATE, rate);
}

void RdData (void)
{
    SetCtrlVal (panel_handle, PANEL_COMM, comport); 
    SetCtrlVal (panel_handle, PANEL_BAUD, baudrate);
    GetIr ();
    GetUp ();
    GetLow ();
    GetAddr ();
    GetBaud ();
}         
    
int CVICALLBACK Measure (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_COMMIT:
            OpenComConfig (comport, devicename, baudrate, 0, 8, 1, 512, 512);
            Communi ();
            RdData ();
            break;
    }
    return 0;
}

int CVICALLBACK Cycle (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_COMMIT:
             SetCtrlAttribute (panel_handle, PANEL_STOP, ATTR_VISIBLE, 1);
             SetCtrlAttribute (panel_handle, PANEL_REC, ATTR_VISIBLE, 1);
             SetCtrlAttribute(panel_handle,PANEL_TIMER,ATTR_ENABLED,1);
             OpenComConfig (comport, devicename, baudrate, 0, 8, 1, 512, 512);
             RdData ();
             break;
    }
    return 0;
}


//measure datas cycly.                                                      
int CVICALLBACK Time (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_TIMER_TICK:
            OpenComConfig (comport, devicename, baudrate, 0, 8, 1, 512, 512);
            Communi();
            break;
    }
    return 0;
}

//record the data.                                                          
int CVICALLBACK Rec (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{   
    switch (event)
    {
        case EVENT_COMMIT: 
            file_handle = LoadPanel (panel_handle, "comm.uir", FILE);
            InstallPopup (file_handle);
            break;
    }
    return 0;
}


//stop measure cycly.
int CVICALLBACK Stop (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_COMMIT:
            SetCtrlAttribute(panel_handle,PANEL_TIMER,ATTR_ENABLED,0);
            SetCtrlAttribute (panel_handle, PANEL_REC, ATTR_VISIBLE, 0);
            break;
    }
    return 0;
}

//Display error information to the user.
void DisplayRS232Error (void)
{
    char ErrorMessage[200];
    switch (RS232Error)
        {
        default :
            if (RS232Error < 0)
                {  
                Fmt (ErrorMessage, "%s<RS232 error number %i", RS232Error);
                MessagePopup ("RS232 Message", ErrorMessage);
                }
            break;
        case 0  :
            MessagePopup ("RS232 Message", "No errors.");
            break;
        case -2 :
            Fmt (ErrorMessage, "%s", "Invalid port number (must be in
                 the " "range 1 to 8).");
            MessagePopup ("RS232 Message", ErrorMessage);
            break;
        case -3 :
            Fmt (ErrorMessage, "%s", "No port is open.\n"
                 "Check COM Port setting in Configure.");
            MessagePopup ("RS232 Message", ErrorMessage);
            break;
        case -99 :
            Fmt (ErrorMessage, "%s", "Timeout error.\n\n"
                 "Either increase timeout value,\n"
                 "       check COM Port setting, or\n"
                 "       check device.");
            MessagePopup ("RS232 Message", ErrorMessage);
            break;
        }
}

//close the comm panel.                                            */
int CVICALLBACK QuitCallback (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_COMMIT:
            SetCtrlAttribute(panel_handle,PANEL_TIMER,ATTR_ENABLED,0);
            QuitUserInterface(0);
            break;
    }
    return 0;
}


int CVICALLBACK SaveFile (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    int fileHandle, numberOfRows;
    Rect cellRange;
    char *logtime[2];
    float curval[2];
    
    //获取用户选择保存的文件名称。
    OPENFILENAME ofn;       // 公共对话框结构。
    TCHAR szFile[MAX_PATH]; // 保存获取文件名称的缓冲区。          
    TCHAR strDefExt[3] = "csv";
 
    // 初始化选择文件对话框。
    ZeroMemory(&ofn, sizeof(ofn));
    ofn.lStructSize = sizeof(ofn);
    ofn.lpstrFile = szFile;
    ofn.lpstrFile[0] = '\0';
    ofn.nMaxFile = sizeof(szFile);
    ofn.lpstrFilter =
        "CSV (*.csv)\0*.CSV\0Text (*.txt)\0*.TXT\0All (*.*)\0*.*\0";
    ofn.nFilterIndex = 1;
    ofn.lpstrFileTitle = NULL;
    ofn.nMaxFileTitle = 0;
    ofn.lpstrInitialDir = NULL;
    ofn.lpstrDefExt = strDefExt;
        
    switch (event)
    {
        case EVENT_COMMIT:
          if (GetSaveFileName(&ofn))
          {
          fileHandle = OpenFile (szFile, VAL_WRITE_ONLY, VAL_TRUNCATE,
                                 VAL_ASCII)
              FmtFile (fileHandle, "日期,时间,电流(A),倍率\n");
              GetNumTableRows (file_handle, FILE_TABLE, &numberOfRows);
              cellRange.height = 1;
              cellRange.width = 2;
              for (j = 1; j <= numberOfRows; j++)
              {
                   cellRange.top = j;
                   cellRange.left = 1;
                   GetTableCellRangeVals (file_handle, FILE_TABLE,
                            cellRange, logtime, VAL_ROW_MAJOR);
                   cellRange.left = 3;
                   GetTableCellRangeVals (file_handle, FILE_TABLE,
                            cellRange, curval, VAL_ROW_MAJOR);

               FmtFile (fileHandle, "%s,%s,%f[p3],%f[p3]\n", logtime[0],
                            logtime[1], curval[0], curval[1]);
               }
                FreeTableValStrings (logtime, 2);
                CloseFile (fileHandle);
            }
            
            if (worksheetHandle)
                CA_DiscardObjHandle(worksheetHandle);
            if (chartHandle)
                CA_DiscardObjHandle(chartHandle);
            if (workbookHandle)
            {
                ExcelRpt_WorkbookClose(workbookHandle, 0);
                CA_DiscardObjHandle(workbookHandle);
            }
            if (applicationHandle)
            {
                ExcelRpt_ApplicationQuit(applicationHandle);
                CA_DiscardObjHandle(applicationHandle);
            }
            DiscardPanel (file_handle);
            break;
    }
    return 0;
}

void InitTable (void)
{
    GetSystemDate (&month, &day, &year);
    GetNumTableRows (file_handle, FILE_TABLE, &numberOfRows);
    cellp.x = 1; cellp.y =  1;
    Fmt(date, "%i[w4]%i[w2p0]%i[w2p0]", year, month, day);
    SetTableCellVal (file_handle, FILE_TABLE, cellp, date);
    cellp.x++;
    SetTableCellVal (file_handle, FILE_TABLE, cellp, TimeStr ());
    cellp.x++;
    SetTableCellVal (file_handle, FILE_TABLE, cellp, data);
    cellp.x++;
    SetTableCellVal (file_handle, FILE_TABLE, cellp, irr); 

}

int CVICALLBACK Switch (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{    
    switch (event)
    {
        case EVENT_COMMIT:
            GetCtrlVal (file_handle, FILE_SWITCH, &status);
            switch (status)
            {
                case 1: InitTable ();
                SetCtrlAttribute(file_handle, FILE_RECORD, ATTR_ENABLED, 1);
                break;
case 0: SetCtrlAttribute(file_handle, FILE_RECORD, ATTR_ENABLED, 0);
                SetCtrlAttribute(file_handle, FILE_OPEN, ATTR_DIMMED, 0);
                break;
            }
             break;
    }
            return 0;
}

int CVICALLBACK Record (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    
    switch (event)
    {
        case EVENT_TIMER_TICK:
            GetSystemDate (&month, &day, &year);
            GetNumTableRows (file_handle, FILE_TABLE, &numberOfRows);
            Communi ();
            InsertTableRows (file_handle, FILE_TABLE,
                numberOfRows + 1, 1, VAL_USE_MASTER_CELL_TYPE);
            cellp.x = 1; cellp.y = numberOfRows + 1;
            Fmt(date, "%i[w4]%i[w2p0]%i[w2p0]", year, month, day);
            SetTableCellVal (file_handle, FILE_TABLE, cellp, date);
            cellp.x++;
            SetTableCellVal (file_handle, FILE_TABLE, cellp, TimeStr ());
            cellp.x++;
            SetTableCellVal (file_handle, FILE_TABLE, cellp, data);
            cellp.x++;
            SetTableCellVal (file_handle, FILE_TABLE, cellp, irr);
            break;
    }
    return 0;
}

int CVICALLBACK Open (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_COMMIT:
          ExcelRpt_ApplicationNew(1, &applicationHandle);
          ExcelRpt_WorkbookNew(applicationHandle, &workbookHandle);
          ExcelRpt_WorksheetNew(workbookHandle, -1, &worksheetHandle);
          ExcelRpt_WriteDataFromTableControl (worksheetHandle, "A1:C30",
                                              file_handle, FILE_TABLE);
          ExcelRpt_RangeBorder (worksheetHandle, "A1:C30", 
                                 ExRConst_Continuous, 255, ExRConst_Thin,
                       ExRConst_InsideHorizontal |
                       ExRConst_InsideVertical | ExRConst_EdgeBottom
                       |ExRConst_EdgeLeft
                       |ExRConst_EdgeRight|ExRConst_EdgeTop);
            SetCtrlAttribute (file_handle, FILE_GRAPH, ATTR_DIMMED, 0);
            break;
    }
    return 0;
}

int CVICALLBACK Graph (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_COMMIT:
            ExcelRpt_SetCellRangeAttribute (worksheetHandle, "A2:A10",
                                            ER_CR_ATTR_COLUMN_WIDTH, 5.0);
          ExcelRpt_ChartAddtoWorksheet (worksheetHandle, 2.0 * 72, 7.0,
                                          10.0*72, 4.0*72, &chartHandle);
          ExcelRpt_ChartWizard (chartHandle, worksheetHandle, "C1:C30",
                                PlotType,0, 0, 0, 0, 1, "Value Time",
                                "Time", "Value", NULL);
          ExcelRpt_SetCellRangeAttribute (worksheetHandle, "A1",
                            ER_CR_ATTR_COLUMN_WIDTH, 10.0);
          ExcelRpt_SetChartAttribute (chartHandle,
                            ER_CH_ATTR_PLOTAREA_COLOR,0xffffff);
            SetCtrlAttribute (file_handle, FILE_RING, ATTR_DIMMED, 0);
            running = 1;
            break;
    }
    return 0;
}

int CVICALLBACK ChartSelect (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
    {
        case EVENT_COMMIT:
            GetCtrlVal (file_handle, FILE_RING, &PlotType);
          if (running) {
        ExcelRpt_ChartWizard (chartHandle, worksheetHandle, "C1:C30",
                              PlotType,0, 0, 0, 0, 1, "Value Time",
                              "Time", "Value", NULL);
        }
            break;
    }
    return 0;
}
``` 
