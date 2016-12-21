// MIT License //<>//
// Copyright (c) 2016 maujaburPFont fonte; 
// 2016/12/21
// Processing 3.2.3

boolean debug = false;
float fontSize = 16; // ajustado palo mouse , botão esquerdo
float limit_w = 286; // ajustado pelo mouse, botão direito
float fontLeading; // espaçamento entre bases das linhas ( rel. tamanho da fonte) 
float largura_blank; // espaçamento entre palavras em pixels
PFont fonte;

void setup() {
  size (800, 800); // tamanho inicial da janela
  surface.setResizable(true); // redimensionável
  //fonte = createFont("BrownStd-Regular.ttf", 32); 
  fonte = createFont("Arial", 32); 
  // fonte na pasta Data ou instalada em seu sistema
}

void draw() {
  // ajustes agrupados para facilitar o uso do TWEAK MODE (ctrl+shit+T)
  background(12, 9, 9); // cor do fundo
  fill(251, 251, 251); // cor do texto
  stroke(0, 255, 0); // cor da linha limite


  // define a largura do caracter espaço
  largura_blank = textWidth(" "); 
  //largura_blank = 0.5*fontSize; 

  // espaçamento entre palavras em pixels
  fontLeading = 1.3;

  float x = 20; // referencia x do começo do texto
  float y = 0; //referencia y do começo do texto

  //String txt = "The quick brown fox jumped over the lazy  dog";
  String txt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sollicitudin ac nisl id volutpat. Quisque vitae tellus ut nulla fermentum ultricies. Aliquam lacus velit, congue a elit at, dictum interdum purus. Vivamus pellentesque ultricies mattis. Phasellus lorem dolor, lobortis at tristique sed, posuere nec dui. Cras gravida nec nisl non venenatis. Phasellus venenatis massa ut nunc sodales rhoncus. Vestibulum maximus, metus id pharetra accumsan, velit turpis rutrum libero, eget mollis ligula libero vel tortor.    ";

  float passoY = fontSize*fontLeading; // pixels entre bases

  // ajuste pelo mouse
  // botão esquerdo desloca largura do texto
  // botão direito controla tamanho da fonte
  if (mousePressed) {
    if (mouseButton == LEFT) {
      limit_w = max (0, mouseX-x);
    } else if (mouseButton == RIGHT) {
      fontSize = max(5, dfontSize *(1+float(mouseY-dmouseY)/50.0));
    } else {
      ;
    }
  }

  textFont(fonte, fontSize);

  // Faz um array com cada palavra sem espaços
  String[] palavras = breakTxt(txt);

  // Faz uma lista com os pontos onde o texto deve ser 
  IntList quebras = getBreaks(palavras, limit_w, largura_blank);

  // exibição dos pontos onde o texto será quebrado
  String ptr = "";
  for (int i = 0; i< quebras.size(); i++) {
    ptr+= quebras.get(i)+" ";
  }
  pushStyle();
  fill(255, 255, 0);
  y += passoY;
  text(ptr, x, y);
  popStyle();

  // desenha um parágrafo
  drawParagraph(palavras, quebras, largura_blank, passoY, x, y, debug);

  //desenha a linha limite
  line(limit_w+x, 0, limit_w+x, height);
}

// ajuste pelo mouse
// botão do meio alterna debug
int dmouseY = 0;
float dfontSize = fontSize;
void mousePressed() {
  dmouseY = mouseY;
  dfontSize = fontSize;
  if (mouseButton == LEFT) {
    ;
  } else if (mouseButton == RIGHT) {
    ;
  } else {
    debug = !debug;
  }
}