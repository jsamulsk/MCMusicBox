;*****************************************************************
;* ClockASM.ASM
;
;Code Entry, Assembly, and Execution 
;(Put your name and date here) 
;--------------------------------------- 
;* -this is the sample code for Lab1
;* -for Full Chip Simulation or Board -- select your target
;* DO NOT DELETE ANY LINES IN THIS TEMPLATE
;* --ONLY FILL IN SECTIONS
;*****************************************************************
; export symbols
            XDEF Entry, _Startup            ; export 'Entry' symbol
            ABSENTRY Entry        ; for absolute assembly: mark this as application entry point

; Include derivative-specific definitions 
		INCLUDE 'derivative.inc' 
		
;-------------------------------------------------- 
; Equates Section  
;----------------------------------------------------  
ROMStart    EQU  $2000  ; absolute address to place my code
TEN     EQU   $80
C2F     EQU   $04
C2I     EQU   $04
IOS2    EQU   $04
PIN5    EQU   %00100000

NOTE_A  EQU   6818
NOTE_B  EQU   6074
NOTE_C  EQU   5733
NOTE_D  EQU   5108
NOTE_E  EQU   4551
NOTE_F  EQU   4295
NOTE_G  EQU   3827
;---------------------------------------------------- 
; Variable/Data Section
;----------------------------------------------------  
            ORG RAMStart   ; loc $1000  (RAMEnd = $3FFF)
; Insert here your data definitions here

CURRNOTE    DS   2
NUMCYCLES   DS   2
 
       INCLUDE 'utilities.inc'
       INCLUDE 'LCD.inc'

;---------------------------------------------------- 
; Code Section
;---------------------------------------------------- 
            ORG   ROMStart  ; loc $2000
Entry:
_Startup:
            ; remap the RAM &amp; EEPROM here. See EB386.pdf
 ifdef _HCS12_SERIALMON
            ; set registers at $0000
            CLR   $11                  ; INITRG= $0
            ; set ram to end at $3FFF
            LDAB  #$39
            STAB  $10                  ; INITRM= $39

            ; set eeprom to end at $0FFF
            LDAA  #$9
            STAA  $12                  ; INITEE= $9
            JSR   PLL_init      ; initialize PLL  
  endif

;---------------------------------------------------- 
; Insert your code here
;---------------------------------------------------- 
        
MAIN
;---SET UP THE (interrupt) SERVICE & INITIALIZE
      SEI             ; turn off interrupts while initializing intr.
      BSET    DDRT, PIN5
      BCLR    PTT, PIN5
        
;---SET UP THE SERVICE (ISR) & INITIALIZE -continued
     
      movb    #TEN,TSCR1     ; enable TCNT
      bset    TIOS,IOS2      ; choose OC2 for timer ch. 2
      movb    #$02,TSCR2     ; set prescaler to 8 (choose initial octave)
      movb    #C2F,TFLG1     ; clear ch 2 flag initially
      cli                    ; allow interupts
      ;---how to play note
      ;LDD     #NOTE_A        ; set current note to A
      ;STD     CURRNOTE
      ;LDD     #2616          ; play current note for 2616/2 = 1308 periods
      ;JSR     play_note      ; CURRNOTE[6818] * 2616 * (1ms/(24000/prescaler[2^3])cycles) = 5945 ms
      ;---end example
      
      JSR     CHORUS
      
      LDD     #NOTE_F       
      STD     CURRNOTE
      LDD     #346           ; 496ms (F quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #346           ; 496ms (F quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #521           ; 746ms (F dotted quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #172           ; 246ms (F eighth note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      
      LDD     #349           ; 500ms (F quarter note)
      JSR     play_note
      LDD     #NOTE_E        
      STD     CURRNOTE
      LDD     #327           ; 496ms (E quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #327           ; 496ms (E quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #162           ; 246ms (E eighth note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #162           ; 246ms (E eighth note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      
      LDD     #330           ; 500ms (E quarter note)
      JSR     play_note
      LDD     #NOTE_D        
      STD     CURRNOTE
      LDD     #291           ; 496ms (D quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #294           ; 500ms (D quarter note)
      JSR     play_note
      LDD     #NOTE_E        
      STD     CURRNOTE
      LDD     #330           ; 500ms (E quarter note)
      JSR     play_note
      
      LDD     #NOTE_D        
      STD     CURRNOTE
      LDD     #587           ; 1000ms (D half note)
      JSR     play_note
      LDD     #NOTE_G        
      STD     CURRNOTE
      LDD     #784           ; 1000ms (G half note)
      JSR     play_note
      
      JSR     CHORUS
      
      LDD     #NOTE_F       
      STD     CURRNOTE
      LDY     #4             ;---play 4 of these notes---
MSR13
      LDD     #346           ; 496ms (F quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      DBNE    Y, MSR13       ;***end loop***
      
      LDD     #349           ; 500ms (F quarter note)
      JSR     play_note
      LDD     #NOTE_E        
      STD     CURRNOTE
      LDD     #327           ; 496ms (E quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #327           ; 496ms (E quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #162           ; 246ms (E eighth note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #165           ; 250ms (E eighth note)
      JSR     play_note
      
      LDD     #NOTE_G        
      STD     CURRNOTE
      LDD     #389           ; 496ms (G quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #392           ; 500ms (G quarter note)
      JSR     play_note
      LDD     #NOTE_F        
      STD     CURRNOTE
      LDD     #349           ; 500ms (F quarter note)
      JSR     play_note
      LDD     #NOTE_D        
      STD     CURRNOTE
      LDD     #294           ; 500ms (D quarter note)
      JSR     play_note
      
      LDD     #NOTE_C        
      STD     CURRNOTE
      LDD     #523           ; 500ms (C whole note)
      JSR     play_note
      
      BRA     *   
;====END OF MAIN ROUTINE

CHORUS
      LDD     #NOTE_E        
      STD     CURRNOTE
      LDD     #327           ; 496ms (E quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #327           ; 496ms (E quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #657           ; 996ms (E half note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      
      LDD     #327           ; 496ms (E quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #327           ; 496ms (E quarter note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      LDD     #657           ; 996ms (E half note)
      JSR     play_note
      LDD     #4             ; 4ms delay
      JSR     ms_delay
      
      LDD     #330           ; 500ms (E quarter note)
      JSR     play_note
      LDD     #NOTE_G        
      STD     CURRNOTE
      LDD     #392           ; 500ms (G quarter note)
      JSR     play_note
      LDD     #NOTE_C        
      STD     CURRNOTE
      LDD     #392           ; 750ms (C dotted quarter note)
      JSR     play_note
      LDD     #NOTE_D        
      STD     CURRNOTE
      LDD     #147           ; 250ms (D eighth note)
      JSR     play_note
      
      LDD     #NOTE_E        
      STD     CURRNOTE
      LDD     #659           ; 1000ms (E whole note)
      JSR     play_note
      RTS

OC2ISR
      MOVB    #C2F,TFLG1  ; clear flag
      LDD     TC2         ; schedule next interrupt
      ADDD    CURRNOTE    ; 30000 cycles = 10ms, CURRNOTE contains appropriate frqeuency
      STD     TC2
      LDAB    PTT         ; toggle PTT5 (speaker)
      EORB    #PIN5       ; "
      STAB    PTT         ; "
      LDX     NUMCYCLES   ; decrement NUMCYCLES
      DEX                 ; "
      STX     NUMCYCLES   ; "  
      RTI

; play_note
; Function: play current note on the speaker for D/2 periods
; Input: D
play_note
      PSHD
      STD     NUMCYCLES
      BSET    TIE,C2I        ; arm OC2

LOOP  LDD     NUMCYCLES      ; check if enough interrupts have occurred
      BHI     LOOP

      BCLR    TIE,C2I        ; disable OC2
      PULD
      RTS
                
;**************************************************************
;*                 Interrupt Vectors                          *
;**************************************************************
            ORG   Vreset
            DC.W  Entry         ; Reset Vector

	          ORG   Vtimch2       ; setup  OC2 Vector
            DC.W  OC2ISR

 