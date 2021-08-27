# MCMusicBox
Microcontroller Music Box Project

Plays Jingle Bells on Dragon12-Plus2 Development Board with MC9S12DG256 Processor. Contains full <a href="https://www.nxp.com/design/software/development-software/codewarrior-development-tools:CW_HOME">CodeWarrior</a> preject. Relevant source code is found at Sources/main.asm

The project builds to an embedded system that plays Jingle Bells on a buzzer located at pin 5 of Port T on the board. It accomplishes this with a subroutine that takes a frequency and a number of periods to play for. It uses a timer subsystem to count.
