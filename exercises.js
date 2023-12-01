// console.log("exercises starting with chapter 2");

const pair = (num1, num2) => {
    return [num1, num2];
}

const head = (array) => {
    return array.shift();
}

const tail = (array) => {
    return array.pop();
}


const x = pair(1, 2);
const firstNumber = head(x);
// console.log(firstNumber)
// 1
const secondNumber = tail(x)
// console.log(secondNumber);
// 2

// Write a function that finds the greatest commond divisor of two numbers in JS
const gcd = (num1, num2) => {
    console.log(num1, num2)
    if (num1 === 0) {
        return num2;
    }
    return gcd(num2 % num1, num1);
};
console.log(gcd(51, 34));