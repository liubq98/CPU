`timescale 1ns / 1ps

module ControlUnit(
    input [5:0] opcode,
    input zero, sign, clk, RST,
    output reg ALUSrcB,
    output reg ALUSrcA,
    output reg [2:0] ALUOp,
    output reg IRWre,
    output reg InsMemRW,
    output reg _RD,
    output reg _WR,
    output reg DBdataSrc,
    output reg ExtSel,
    output reg [1:0] RegDst,
    output reg WrRegDSrc,
    output reg RegWre,
    output reg PCWre,
    output reg [1:0] PCSrc,
    output reg [2:0] state_out //�����һ����������ڶ���ģ��������Σ����ڷ���ʵ�����͵���
    );
    //����״̬����,���Ӵ���ɶ���
	parameter [2:0] IF = 3'b000,
                      ID = 3'b001,
                    EXE1 = 3'b110,
                    EXE2 = 3'b101,
                    EXE3 = 3'b010,
                     MEM = 3'b011,  
                     WB1 = 3'b111,
                     WB2 = 3'b100;                            
    parameter [5:0] add = 6'b000000,
                      addi = 6'b000010,
                       sub = 6'b000001,
                        Or = 6'b010000,
                       ori = 6'b010010,
                       And = 6'b010001,
                       slt = 6'b100110,
                      slti = 6'b100111,  
                       sll = 6'b011000,
                        sw = 6'b110000,  
                        lw = 6'b110001,  
                       beq = 6'b110100, 
                      bltz = 6'b110110,
                         j = 6'b111000,  
                        jr = 6'b111001,  
                       jal = 6'b111010,
                      halt = 6'b111111;         
    reg [2:0] state, next_state;
    
    //�൱���ں���D��������ʱ���½��ص�ʱ�л�״̬
    always @(negedge clk) begin  
        if (RST) state <= IF;  
        else state <= next_state;
        state_out <= state;
    end
       
    //��һ״̬��   
    always @(state or opcode) begin  
        case(state)  
            IF: next_state = ID;  
            ID: begin  
                case (opcode[5:3]) //���ݲ�����ǰ��λ������һ״̬
                    3'b111: next_state = IF; //j, jal, jr, halt
                    3'b110: begin
                        if (opcode == beq || opcode == bltz) next_state = EXE2; //beq, bltz
                        else next_state = EXE3; //sw, lw
                    end  
                    default: next_state = EXE1; //����ָ��  
                endcase  
            end
            EXE1: next_state = WB1;  
            EXE2: next_state = IF;  
            EXE3: next_state = MEM;  
            MEM: begin  
                if (opcode == 6'b110001) next_state = WB2; //lwָ��  
                else next_state = IF; //swָ��  
            end  
            WB1: next_state = IF;  
            WB2: next_state = IF;  
            default: next_state = IF;  
        endcase  
    end  
            
    //����źſ飬����һ���߼���·��ֻ����state���������ı��ʱ��ȥ������Щ�źŵ�ֵ           
    always @(state) begin 
        if (state == IF) begin
            if(opcode == halt) PCWre = 0;
            else PCWre = 1; //ֻ����ȡַ�׶��ҷ�ͣ��ָ��ʱPC�Ż�ı�
        end
        else PCWre = 0;
                  
        InsMemRW = 1; //����Ҫ����ź�
           
        if (opcode == sll) ALUSrcA = 1; //ֻ��λ��ָ��SrcA��Ҫ��sa������
        else ALUSrcA = 0;
                        
        if (opcode == addi || opcode == ori || opcode == slti || opcode == sw || opcode == lw) ALUSrcB = 1; //��Щָ����SrcBȡ��չ���������
        else ALUSrcB = 0;
           
        if (opcode == lw) DBdataSrc = 1; //lwָ���¸��źű�ʾȡ��MEM��ȡ��������
        else DBdataSrc = 0;
                 
        if (state == WB1 || state == WB2 || opcode == jal) RegWre = 1; //��д�ؽ׶λ���jalָ��ʱ��Ҫ�üĴ�������дָ��
        else RegWre = 0;
       
        if (opcode == jal) WrRegDSrc = 0; //ֻ��jalָ��ʱд�ؼĴ���������ȡ����PC + 4
        else WrRegDSrc = 1;
       
        if (state == MEM && opcode == sw) _WR = 0; //sw��lw��صĶ�д�źţ�����͵�ƽ��ʾ��Ч
        else _WR = 1;  
        if (state == MEM && opcode == lw) _RD = 0;  
        else _RD = 1; 
       
        if (state == IF) IRWre = 1; //IR�Ĵ�����IF�׶νӵ����ָ��֮�󣬵�ʱ�������صĵ����ʹ�IRMRM�ж������ָ��
        else IRWre = 0;
       
        if (opcode == ori || opcode == slti) ExtSel = 0; //ֻ��oriָ�������޷�����չ 
        else ExtSel = 1;
        
        if (opcode == jal) RegDst = 2'b00; //jalָ���¼Ĵ���д�صĵ�ַΪ$31����
        else if (opcode == addi || opcode == ori || opcode == slti || opcode == lw) RegDst = 2'b01;  
        else RegDst = 2'b10;
              
        case(opcode) //������źű�����ʾ���������
            j: PCSrc = 2'b11;  
            jal: PCSrc = 2'b11;  
            jr: PCSrc = 2'b10;  
            beq: begin  
                if (zero) PCSrc = 2'b01;  
                else PCSrc = 2'b00;  
            end
            bltz: begin  
                if (zero == 0) PCSrc = 2'b01;  
                else PCSrc = 2'b00;  
            end 
            default: PCSrc = 2'b00;  
        endcase  
              
        case(opcode) //ȡ���ڲ�ָͬ���Ӧ���߼��������
            sub: ALUOp = 3'b001;  
            Or: ALUOp = 3'b101; 
            ori: ALUOp = 3'b101; 
            And: ALUOp = 3'b110;
            slt: ALUOp = 3'b010;  
            slti: ALUOp = 3'b010;
            sll: ALUOp = 3'b100;  
            beq: ALUOp = 3'b001;
            bltz: ALUOp = 3'b010;
            default: ALUOp = 3'b000;
        endcase
        
        if (state == IF) begin // ��ֹ��IF�׶�д����  
            RegWre = 0;
            _WR = 1;  
        end  
    end
    
endmodule
