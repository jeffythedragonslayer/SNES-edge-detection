;------------------------------------------------------------------------------
;- RAM Definiton
;------------------------------------------------------------------------------
Cont1L  ds  1                   ; Controller #1 data low byte
Cont1H  ds  1                   ; Controller #1 data high byte
Cont2L  ds  1                   ; Controller #2 data low byte
Cont2H  ds  1                   ; Controller #2 data high byte
Trig1L  ds  1                   ; Trigger data of controller #1
Trig1H  ds  1                   ;
Trig2L  ds  1                   ; Trigger data of controller #2
Trig2H  ds  1                   ;
;------------------------------------------------------------------------------
;- Read Controller
;------------------------------------------------------------------------------
RdCont;
        push
        a8                      ; Accumulator 8-bit
RdCont_Wait1
        LDA     HVBJoy          ; <4212>
        AND     #%00000001
        BEQ     RdCont_Wait1
RdCont_Wait2
        LDA     HVBJoy
        AND     #%00000001
        BNE     RdCont_Wait2
        a16                     ; Accumulator 16-bit
        i16                     ; Index 16-bit
RdCont_Cont1
        LDY     Cont1L          ; Keep last data in "IY"
        LDA     Joy1L           ; <4218> (Cont1-L)
        STA     Cont1L          ; Store new controller data
        TYA                     ; <edge detection>
        EOR     Cont1L
        AND     Cont1L
        STA     Trig1L          ; Store trigger data
RdCont_Cont2
        LDY     Cont2L          ; Keep last data in "IY"
        LDA     Joy2L           ; <421AH> (Cont2-L)
        STA     Cont2L          ; Store new controller data
        TYA                     ; <edge detection>
        EOR     Cont2L
        AND     Cont2L
        STA     Trig2L          ; Store trigger data
        pop
        RTS