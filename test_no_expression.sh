#! /bin/bash

S1="========================================================================================================="
S2="---------------------------------------------------------------------------------------------------------"
GREEN="\033[38;2;57;181;74m"
RED="\033[38;2;222;56;43m"
BLUE="\033[38;2;34;183;235m"
YELLOW="\033[38;2;255;176;0m"
PURPLE="\033[38;2;255;105;180m"
RESET="\033[0m"

comp() {
	printf "$RED"; diff -u $1 $2
	if [ $? -eq 0 ]; then
		printf "$GREEN""OK !$RESET\n"
	fi
}

printf "\n$YELLOW$S1$RESET\n"
printf "$BLUE"; make re;
printf "$YELLOW$S1$RESET\n"

echo "hello world" > out1.txt
echo "hello world" > out2.txt
printf "$PURPLE""TEST 01: find\n"
printf "$PURPLE$S2$RESET\n"
< main.c find /Users/thi-nguy/Documents/pipex_final/ -user thi-nguy | wc -l > out1.txt
./pipex  main.c "find /Users/thi-nguy/Documents/pipex_final/ -user thi-nguy" "wc -l"  out2.txt
cat out1.txt
echo
cat out2.txt
comp out1.txt out2.txt
rm *.txt
printf "$YELLOW$S1$RESET\n"

echo "hello world" > out1.txt
echo "hello world" > out2.txt
printf "$PURPLE""TEST 02: grep\n"
< main.c grep -i return | cat > out1.txt
./pipex main.c "grep -i return" "cat" out2.txt
printf "$PURPLE$S2$RESET\n"
cat out1.txt
echo
cat out2.txt
comp out1.txt out2.txt
rm *.txt
printf "$YELLOW$S1$RESET\n"

echo 'fool\\\\bar' > out1.txt
echo 'fool\\\\bar' > out2.txt
printf "$PURPLE""TEST 02c: grep -F.\n"
< main.c grep -F fool\\bar | echo > out1.txt
./pipex main.c "grep -F fool\bar" "echo" out2.txt
printf "$PURPLE$S2$RESET\n"
cat out1.txt
echo
cat out2.txt
comp out1.txt out2.txt
rm *.txt
printf "$YELLOW$S1$RESET\n"

echo "hello world" > out1.txt
echo "hello world" > out2.txt
printf "$PURPLE""TEST 03: command with no argument 01.\n"
< main.c ls | wc -l > out1.txt
./pipex main.c "ls" "wc -l" out2.txt
printf "$PURPLE$S2$RESET\n"
cat out1.txt
echo
cat out2.txt
comp out1.txt out2.txt
rm *.txt
printf "$YELLOW$S1$RESET\n"

printf "$PURPLE""TEST 03b: command with no argument 02.\n"
< main.c ls | grep .c > out1.txt
./pipex main.c "ls" "grep .c" out2.txt
printf "$PURPLE$S2$RESET\n"
cat out1.txt
echo
cat out2.txt
comp out1.txt out2.txt
rm *.txt
printf "$YELLOW$S1$RESET\n"

echo "hello world" > out1.txt
echo "hello world" > out2.txt
printf "$PURPLE""TEST 04: echo without quotes\n"
< main.c grep -i return | echo hello    world > out1.txt
./pipex main.c "grep -i return" "echo hello    world" out2.txt
printf "$PURPLE$S2$RESET\n"
cat out1.txt
echo
cat out2.txt
comp out1.txt out2.txt
rm *.txt
printf "$YELLOW$S1$RESET\n"


echo "Hello how are you doing" > file1.txt
echo "Hello how are you doing" > file2.txt
printf "$PURPLE""TEST 05: same input and output file\n"$RESET
printf "$PURPLE$S2$RESET\n"
< file1.txt grep are | wc -l > file1.txt
./pipex file2.txt "grep are" "wc -l" file2.txt
cat file1.txt
echo
cat file2.txt
comp file1.txt file2.txt
rm *.txt
printf "$YELLOW$S1$RESET\n"


printf "$PURPLE""TEST 06: head\n"$RESET
printf "$PURPLE$S2$RESET\n"
< main.c head | wc -l > file1.txt
./pipex main.c "head" "wc -l" file2.txt
cat file1.txt
echo
cat file2.txt
comp file1.txt file2.txt
rm *.txt
printf "$YELLOW$S1$RESET\n"


printf "$PURPLE""TEST 07: file\n"$RESET
printf "$PURPLE$S2$RESET\n"
< main.c file | grep text > file1.txt
./pipex main.c "file" "grep text" file2.txt
cat file1.txt
echo
cat file2.txt
comp file1.txt file2.txt
rm *.txt

printf "$PURPLE""TEST 08: illegal option\n"$RESET
printf "$PURPLE$S2$RESET\n"
< main.c wc -slslksdfow | grep a > out1.txt
./pipex main.c "wc -slslksdfow" "grep a" out2.txt
cat out1.txt
echo
cat out2.txt
comp out1.txt out2.txt
rm *.txt

printf "$PURPLE""TEST 08b: illegal option\n"$RESET
printf "$PURPLE$S2$RESET\n"
< main.c ls -slslksdfow | wc -seew > out1.txt
./pipex main.c "ls -slslksdfow" "wc -seew" out2.txt
cat out1.txt
echo
cat out2.txt
comp out1.txt out2.txt
rm *.txt



printf "\n$GREEN$S1$RESET\n"
printf "$GREEN""Handling ERROR Tests: Should stop program and print ERROR message.\n"
printf "$GREEN$S1$RESET\n"

printf "$PURPLE""TEST 01: non existing file\n"$RESET
printf "$PURPLE$S2$RESET\n"
./pipex main "grep -i return" "echo hello    world" out.txt
printf "$YELLOW$S1$RESET\n"

printf "$PURPLE""TEST 02: non existing command\n"$RESET
printf "$PURPLE$S2$RESET\n"
./pipex main.c "abc xyz lha9" "echo hello    world" out.txt
printf "$YELLOW$S1$RESET\n"

printf "$PURPLE""TEST 03: Null command\n"$RESET
printf "$PURPLE$S2$RESET\n"
./pipex main.c "" "wc -l" out2.txt
printf "$YELLOW$S1$RESET\n"

printf "$PURPLE""TEST 03: Null command\n"$RESET
printf "$PURPLE$S2$RESET\n"
./pipex main.c "ls -la" "" out2.txt
printf "$YELLOW$S1$RESET\n"

printf "$PURPLE""TEST 03: Null input file\n"$RESET
printf "$PURPLE$S2$RESET\n"
./pipex "" "ls -la" "wc -l" out2.txt
printf "$YELLOW$S1$RESET\n"

