package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func part1(arr []int) {
	var last = 0x7fffffff
	var rtn = 0
	for x := range arr {
		if arr[x] > last {
			rtn++
		}
		last = arr[x]
	}
	fmt.Println(rtn)
}

func part2(arr []int) {
	var last = 0x7fffffff
	var rtn = 0
	for x := range arr {
		if x+2 < len(arr) {
			sum := arr[x] + arr[x+1] + arr[x+2]
			if sum > last {
				rtn++
			}
			last = sum

		}
	}
	fmt.Println(rtn)
}

func main() {
	input, _ := os.ReadFile("input/day1")
	arr := strings.Split(string(input), "\n")
	var intArr = []int{}
	for i := range arr {
		x, _ := strconv.Atoi(arr[i])
		intArr = append(intArr, x)
	}
	part1(intArr)
	part2(intArr)
}
