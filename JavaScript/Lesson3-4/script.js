//Домашнее к 3 уроку

//1. С помощью цикла while вывести все простые числа в промежутке от 0 до 100.
'use strict';


let i = 0;
while (i < 100) {
    if (isNumber(i)) {
        console.log(i)
    }
    i++;
}


function isNumber(number) {
    if (number < 2) {
        return false
    }
    for (let i = 2; i <= Math.sqrt(number); i++) {
        if (number % i === 0) {
            return false;
        }
        return true;
    }
}





//2. С этого урока начинаем работать с функционалом интернет-магазина. Предположим, есть сущность корзины. Нужно реализовать функционал подсчета стоимости корзины в зависимости от находящихся в ней товаров. Товары в корзине хранятся в массиве. Задачи:
//a) Организовать такой массив для хранения товаров в корзине;
//b) Организовать функцию countBasketPrice, которая будет считать стоимость корзины.



let basket = [
    {
        id: 1,
        name: "Phone",
        price: 3200,
        quaility: 1
    },
    {
        id: 2,
        name: "Ipad",
        price: 3700,
        quaility: 1
    }
];


function countBasketPrice(basket) {
    let totalPrice = 0;
    for (let i = 0; i < basket.length; i++) {
        totalPrice += basket[i].price;
    }
    return totalPrice;
}

console.log(countBasketPrice(basket));

//3.Вывести с помощью цикла for числа от 0 до 9, не используя тело цикла.

for (let i = 0; i < 10; console.log(i++)) { }








//Домашнее задание к уроку 4

//1. Написать функцию, преобразующую число в объект. Передавая на вход число от 0 до 999, мы должны получить на выходе объект, в котором в соответствующих свойствах описаны единицы, десятки и сотни. Например, для числа 245 мы должны получить следующий объект: {‘единицы’: 5, ‘десятки’: 4, ‘сотни’: 2}. Если число превышает 999, необходимо выдать соответствующее сообщение с помощью console.log и вернуть пустой объект.




let UserNumber = parseInt(prompt("Введите число от 0 до 999  "))

function CutNumber(number) {
    if (number > 999 || number < 0 || isNaN(number)) {
        alert("Введенное значение либо не является числом либо не входит в  необходимый диапазон")
        var obj = {};
        return obj;
    } else {
        var digits = ['единицы', 'десятки', 'сотни'];
        var obj = {};
        var i = 0;
        for (var i = 0; number != 0; i++) {
            obj[digits[i]] = number % 10;
            number = (number - number % 10) / 10;
        }
    }
    return obj;
}

console.log(CutNumber(UserNumber))





//2. Для игры, реализованной на уроке, добавить ограничения,
// чтобы игрок не выходил за пределы поля 
// Сделал по примеру


const settings = {
    rowsCount: 10,
    colsCount: 10,
    startPositionX: 0,
    startPositionY: 0,
};

const player = {
    x: null,
    y: null,


    init(startX, startY) {
        this.x = startX;
        this.y = startY;
    },


    move(nextPoint) {
        this.x = nextPoint.x;
        this.y = nextPoint.y;
    },

    getNextPosition(direction) {

        const nextPosition = {
            x: this.x,
            y: this.y,
        };

        switch (direction) {
            case 1:
                nextPosition.x--;
                nextPosition.y++;
                break;
            case 2:
                nextPosition.y++;
                break;
            case 3:
                nextPosition.x++;
                nextPosition.y++;
                break;
            case 4:
                nextPosition.x--;
                break;
            case 6:
                nextPosition.x++;
                break;
            case 7:
                nextPosition.x--;
                nextPosition.y--;
                break;
            case 8:
                nextPosition.y--;
                break;
            case 9:
                nextPosition.x++;
                nextPosition.y--;
                break;
        }

        return nextPosition;
    },
};


const game = {
    settings,
    player,


    run() {

        this.player.init(this.settings.startPositionX, this.settings.startPositionY);

        while (true) {

            this.render();


            const direction = this.getDirection();


            if (direction === -1) {
                alert('До свидания.');
                return;
            }


            const nextPoint = this.player.getNextPosition(direction);

            if (this.canPlayerMakeStep(nextPoint)) {
                this.player.move(nextPoint);
            }
        }
    },


    render() {

        let map = "";


        for (let row = 0; row < this.settings.rowsCount; row++) {

            for (let col = 0; col < this.settings.colsCount; col++) {

                if (this.player.y === row && this.player.x === col) {
                    map += 'o ';
                } else {
                    map += 'x ';
                }
            }

            map += '\n';
        }


        console.clear();

        console.log(map);
    },


    getDirection() {

        const availableDirections = [-1, 1, 2, 3, 4, 6, 7, 8, 9];

        while (true) {

            let direction = parseInt(prompt('Введите число, куда вы хотите переместиться, -1 для выхода.'));


            if (!availableDirections.includes(direction)) {
                alert(`Для перемещения необходимо ввести одно из чисел: ${availableDirections.join(', ')}.`);
                continue;
            }


            return direction;
        }
    },


    canPlayerMakeStep(nextPoint) {
        return nextPoint.x >= 0 &&
            nextPoint.x < this.settings.colsCount &&
            nextPoint.y >= 0 &&
            nextPoint.y < this.settings.rowsCount;
    },
};


game.run();


//3.Продолжить работу с интернет-магазином:
//3.1. В прошлом домашнем задании вы реализовали корзину на базе массивов. Какими объектами можно заменить их элементы?
//3.2. Реализуйте такие объекты.
//3.3. Перенести функционал подсчета корзины на объектно-ориентированную базу.




let basket = {
    goods: [
        {
            id: 1,
            name: "Phone",
            price: 3200,
            quaility: 1
        },
        {
            id: 2,
            name: "Ipad",
            price: 3700,
            quaility: 1
        }
    ],

    BasketPtice() {
        return this.goods.reduce((totalPrice, cartItem) => totalPrice += cartItem.price, 0);
    }

};