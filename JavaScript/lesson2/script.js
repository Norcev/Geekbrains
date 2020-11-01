//  1. Почему код даёт именно такие результаты?

var a = 1, b = 1, c, d;
c = ++a; alert(c);           // 2           +a означает что мы к переменной а прибавляем единицу
d = b++; alert(d);           // 1           b++ после переменной означает, что мы прибавляем единицу, но выводим предыдущее значение переменной
c = (2 + ++a); alert(c);     // 5           В первом примере мы прибавляли единицу и значение a = 2  тут мы увиличеваем a на 1 и прибавляем 2; 2 + 3 = 5
d = (2 + b++); alert(d);     // 4           Во втором примере мы прибавляли единицу и значение b = 2  тут мы увиличеваем a на 1  но  выводим предыдушие значение 2 и 2 + 2 = 4
alert(a);                    // 3           Прибавили 1 в примере  1 и 3
alert(b);                    // 3           Прибавили 1 в примере  2 и 4


// 2. Чему будет равен x в примере ниже ?

var a = 2;
var x = 1 + (a *= 2);
alert(x)

// Ответ x = 5 тк сначала выполняется задание в скобках (2 * 2) = 4 и прибавляется 1 


// 3. Объявить две целочисленные переменные a и b и задать им произвольные начальные значения. Затем написать скрипт, который работает по следующему принципу:
// если a и b положительные, вывести их разность;
// если а и b отрицательные, вывести их произведение;
// если а и b разных знаков, вывести их сумму; ноль можно считать положительным числом.


var a = prompt("Введите первое число")
var b = prompt("Введите второе число")

function deduction(a, b) {
    if (a > 0 && b > 0) {
        y = Math.max(a, b);
        z = Math.min(a, b);
        x = y - z;
        alert("Разность чисел равна  " + x);
    } else if (a < 0 && b < 0) {
        x = a * b;
        alert("Произведение отрицательных чисел равно " + x);
    } else if (a >= 0 || b >= 0) {
        x = +a + +b;
        alert("Сумма чисел равна " + x);
    } else if (isNaN(a) || isNaN(b)) {
        alert("Ошибка введенных данных");
    }
}

deduction(a, b);


// 4. Присвоить переменной а значение в промежутке [0..15]. С помощью оператора switch организовать вывод чисел от a до 15.

var a = prompt("Введите число от 0 до 15")

function calc(a) {
    if (a > 15 || a < 0) {
        x = a;
        alert("Число " + x + " не входит в диапазон от 0 до 15");
    } else if (a >= 0 && a < 15) {
        x = a;
        switch (+x) {
            case 0:
                document.write("0 ");
            case 1:
                document.write("1 ");
            case 2:
                document.write("2 ");
            case 3:
                document.write("3 ");
            case 4:
                document.write("4 ");
            case 5:
                document.write("5 ");
            case 6:
                document.write("6 ");
            case 7:
                document.write("7 ");
            case 8:
                document.write("8 ");
            case 9:
                document.write("9 ");
            case 10:
                document.write("10 ");
            case 11:
                document.write("11 ");
            case 12:
                document.write("12 ");
            case 13:
                document.write("13 ");
            case 14:
                document.write("14 ");
            case 15:
                document.write("15 ");
        }
    } else if (isNaN(a)) {
        alert("Введены не коректные данные")
    }
}

calc(a);

// 5. Реализовать основные 4 арифметические операции в виде функций с двумя параметрами. Обязательно использовать оператор return.

var a = parseInt(prompt("Введите первое число"))
var b = parseInt(prompt("Введите второе число"))

function plus(a, d) {
    return a + b;
}

function minus(a, d) {
    return a - b;
}

function division(a, d) {
    return a / b;
}

function multiplication(a, d) {
    return a + b;
}

if (isNaN(a) || isNaN(b)) {
    alert("Введены не коректные данные")
} else if (a != 0 && b != 0) {
    document.write("Результат сложения = " + plus(a, b) + "  ");
    document.write("Результат вычитания = " + minus(a, b) + "  ");
    document.write("Результат деления  = " + division(a, b) + "  ");
    document.write("Результат умножения  = " + multiplication(a, b) + "  ");
} else {
    document.write("Результат сложения = " + plus(a, b) + "  ");
    document.write("Результат вычитания = " + minus(a, b) + "  ");
    document.write("На ноль делить нельзя  ");
    document.write("Результат умножения  = " + multiplication(a, b) + "  ");
}