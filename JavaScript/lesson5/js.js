// Домашнее задание к уроку 5



// Создать функцию, генерирующую шахматную доску. При этом можно использовать любые html-теги по своему желанию. Доска должна быть разлинована соответствующим образом, т.е. чередовать черные и белые ячейки. Строки должны нумероваться числами от 1 до 8, столбцы – латинскими буквами A, B, C, D, E, F, G, H.


var container = document.querySelector(".container");
container.style.background = "brown";
container.style.width = "660px";
container.style.height = "660px";
container.style.paddingLeft = "60px";
container.style.paddingBottom = "60px";
container.style.margin = "0 auto";
container.style.display = "flex";
container.style.flexWrap = "wrap";

function my_initiation() {
  var cell = document.createElement("div");
  cell.className = "cell";
  cont.append(cell);
  cell.style.width = "60px";
  cell.style.height = "60px";
  cell.style.margin = "0px";
  cell.style.padding = "0px";
  cell.style.fontSize = "40px";
  cell.style.fontWeight = "bold";
  cell.style.textAlign = "center";

}
window.onload = my_initiation;

for (var n = 0; (n != 121); n++) {
  window.onload = my_initiation();
};

var masCell = document.querySelectorAll(".cell");
for (var i = 0; (i < masCell.length); i++) {
  var c;
  if (i % 2 == 0) {
    c = "dimgrey";
  } else {
    c = "bisque";
  }
  masCell[i].style.background = c;
  if ((i > 33) && (i < 42)) {
    masCell[i].innerText = "P";
  };
  if ((i > 88) && (i < 97)) {
    masCell[i].innerText = "P";
  };

  masCell[23].innerText = "A";
  masCell[24].innerText = "B";
  masCell[25].innerText = "C";
  masCell[26].innerText = "D";
  masCell[27].innerText = "E";
  masCell[28].innerText = "F";
  masCell[29].innerText = "G";
  masCell[30].innerText = "H";

  masCell[100].innerText = "A";
  masCell[101].innerText = "B";
  masCell[102].innerText = "C";
  masCell[103].innerText = "D";
  masCell[104].innerText = "E";
  masCell[105].innerText = "F";
  masCell[106].innerText = "G";
  masCell[107].innerText = "H";

  for (var f = 89; (f < 108); f++) {
    masCell[f].style.color = "white";
  }
  for (var f = 0; (f < 22); f++) {
    masCell[f].style.background = "brown";
  }
  for (var f = 110; (f < 121); f++) {
    masCell[f].style.background = "brown";
  }

  masCell[22].style.background = "brown";
  masCell[33].style.background = "brown";
  masCell[44].style.background = "brown";
  masCell[55].style.background = "brown";
  masCell[66].style.background = "brown";
  masCell[77].style.background = "brown";
  masCell[88].style.background = "brown";
  masCell[99].style.background = "brown";
  masCell[31].style.background = "brown";
  masCell[32].style.background = "brown";
  masCell[42].style.background = "brown";
  masCell[43].style.background = "brown";
  masCell[53].style.background = "brown";
  masCell[54].style.background = "brown";
  masCell[64].style.background = "brown";
  masCell[65].style.background = "brown";
  masCell[75].style.background = "brown";
  masCell[76].style.background = "brown";
  masCell[86].style.background = "brown";
  masCell[87].style.background = "brown";
  masCell[97].style.background = "brown";
  masCell[98].style.background = "brown";
  masCell[108].style.background = "brown";
  masCell[109].style.background = "brown";

  masCell[12].innerText = "A";
  masCell[13].innerText = "B";
  masCell[14].innerText = "C";
  masCell[15].innerText = "D";
  masCell[16].innerText = "E";
  masCell[17].innerText = "F";
  masCell[18].innerText = "G";
  masCell[19].innerText = "H";
  masCell[111].innerText = "A";
  masCell[112].innerText = "B";
  masCell[113].innerText = "C";
  masCell[114].innerText = "D";
  masCell[115].innerText = "E";
  masCell[116].innerText = "F";
  masCell[117].innerText = "G";
  masCell[118].innerText = "H";

  masCell[97].style.color = "black";
  masCell[99].style.color = "black";

  masCell[22].innerText = "1";
  masCell[33].innerText = "2";
  masCell[44].innerText = "3";
  masCell[55].innerText = "4";
  masCell[66].innerText = "5";
  masCell[77].innerText = "6";
  masCell[88].innerText = "7";
  masCell[99].innerText = "8";
  masCell[31].innerText = "1";
  masCell[42].innerText = "2";
  masCell[53].innerText = "3";
  masCell[64].innerText = "4";
  masCell[75].innerText = "5";
  masCell[86].innerText = "6";
  masCell[97].innerText = "7";
  masCell[108].innerText = "8";
}



//Сделать генерацию корзины динамической: верстка корзины не должна находиться в HTML-структуре. Там должен быть только div, в который будет вставляться корзина, сгенерированная на базе JS:


// Запутался сделал по вашему примеру

const cartItem = {
  render(good) {
    return `<div class="good">
                  <div><b>Наименование</b>: ${good.product_name}</div>
                  <div><b>Цена за шт.</b>: ${good.price}</div>
                  <div><b>Количество</b>: ${good.quantity}</div>
                  <div><b>Стоимость</b>: ${good.quantity * good.price}</div>
              </div>`;
  }
}

const cart = {
  cartListBlock: null,
  cartButton: null,
  cartItem,
  goods: [
    {
      id_product: 123,
      product_name: 'PC',
      price: 45600,
      quantity: 1,
    },
    {
      id_product: 456,
      product_name: 'Iphone',
      price: 1000,
      quantity: 2,
    },
    {
      id_product: 305,
      product_name: 'Airpods',
      price: 2000,
      quantity: 1,
    },
  ],
  init() {
    this.cartListBlock = document.querySelector('.cart-list');
    this.cartButton = document.querySelector('.cart-btn');
    this.cartButton.addEventListener('click', this.clearCart.bind(this));

    this.render();
  },
  render() {
    if (this.goods.length) {
      this.goods.forEach(good => {
        this.cartListBlock.insertAdjacentHTML('beforeend', this.cartItem.render(good));
      });
      this.cartListBlock.insertAdjacentHTML('beforeend', `В корзине ${this.goods.length} позиций(а) стоимостью ${this.getCartPrice()}`);
    } else {
      this.cartListBlock.textContent = 'Корзина пуста';
    }
  },
  getCartPrice() {
    return this.goods.reduce(function (price, good) {
      return price + good.price * good.quantity;
    }, 0);
  },
  clearCart() {
    this.goods = [];
    this.render();
  },
};

cart.init();
