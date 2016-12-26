// MIT License //<>// //<>//
// Copyright (c) 2016 maujaburPFont fonte; 
// 2016/12/21
// Processing 3.2.3

String txt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sollicitudin ac nisl id volutpat. Quisque vitae tellus ut nulla fermentum ultricies. Aliquam lacus velit, congue a elit at, dictum interdum purus. Vivamus pellentesque ultricies mattis. Phasellus lorem dolor, lobortis at tristique sed, posuere nec dui. Cras gravida nec nisl non venenatis. Phasellus venenatis massa ut nunc sodales rhoncus. Vestibulum maximus, metus id pharetra accumsan, velit turpis rutrum libero, eget mollis ligula libero vel tortor.\n\nVivamus sit amet nulla leo. Etiam ac neque est. Vestibulum faucibus ut mi quis viverra. Nunc ac mauris quam. Aliquam erat volutpat. Proin porttitor eleifend eros. Suspendisse consectetur lectus rhoncus laoreet vestibulum.\n\nQuisque vel egestas lorem. Vivamus in enim bibendum, ultricies mi vitae, suscipit dui. Morbi sodales aliquet lorem vel congue. Ut fringilla orci malesuada odio ultricies lacinia. Sed nec quam vitae quam suscipit ultrices et in mi. Vestibulum quis odio viverra, tincidunt magna sed, faucibus odio. Sed pulvinar arcu elementum suscipit ultricies. Integer at velit metus. Nulla laoreet sem ac ornare auctor. Etiam ultrices orci ac massa mattis, id auctor erat mollis. In bibendum metus at arcu elementum, non condimentum lectus finibus. Sed condimentum erat vel sem posuere iaculis. Proin euismod cursus elementum. Mauris in convallis lorem. Aenean id placerat dui. Nulla a dui sit amet leo rutrum maximus non feugiat nunc.\n\nNulla id velit elementum, hendrerit nulla et, accumsan neque. Donec posuere dapibus neque sit amet scelerisque. Integer pretium pulvinar aliquam. Proin sed egestas orci. Aenean eu ornare justo. Nam quis fermentum mauris. Maecenas tincidunt, mauris vitae vulputate pharetra, magna libero luctus neque, non ornare velit odio sit amet arcu. Sed dignissim urna dolor, a porta nisl tristique id. Praesent sed nunc porttitor, placerat erat a, vestibulum tellus. Sed at risus elit. Fusce a mi tempor, tempor orci in, tempor ligula. Interdum et malesuada fames ac ante ipsum primis in faucibus. Curabitur bibendum eros sem, tincidunt porttitor augue molestie a. Donec lorem purus, aliquet consectetur sapien et, consectetur dignissim nibh. Phasellus eget quam placerat, egestas massa ut, placerat tellus. Aenean eget orci at eros pellentesque blandit in eget nisl.\n\nVivamus nec gravida libero. Sed non sem efficitur, posuere ex et, ultricies risus. Vivamus iaculis quam eu velit lobortis, ut luctus turpis sagittis. Praesent suscipit, augue id commodo hendrerit, eros tellus ultrices diam, vitae consequat odio neque ut mauris. Quisque pulvinar nisi nunc. Sed rutrum, diam a pellentesque blandit, ante ex pulvinar risus, sit amet blandit mauris nibh ut lectus. Phasellus ut sagittis nisi. Pellentesque iaculis egestas lectus, id aliquam urna pharetra in. Praesent aliquet vestibulum arcu, mattis consequat dui maximus et. Vivamus facilisis elit vitae nibh ullamcorper suscipit eget quis mi. Maecenas elementum eros in mollis posuere. Suspendisse potenti. Cras vestibulum diam sit amet sem molestie lacinia. Sed sagittis ac libero eu ultrices.";


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
  float y = 5; //referencia y do começo do texto

  //String txt = "The quick brown fox jumped over the lazy  dog";
  //String txt = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sollicitudin ac nisl id volutpat. Quisque vitae tellus ut nulla fermentum ultricies. Aliquam lacus velit, congue a elit at, dictum interdum purus. Vivamus pellentesque ultricies mattis. Phasellus lorem dolor, lobortis at tristique sed, posuere nec dui. Cras gravida nec nisl non venenatis. Phasellus venenatis massa ut nunc sodales rhoncus. Vestibulum maximus, metus id pharetra accumsan, velit turpis rutrum libero, eget mollis ligula libero vel tortor.    ";

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

  // desenha um retangulo em torno do texto
  pushStyle();
  fill(20);
  stroke(255, 0, 0);
  strokeWeight(3);
  rect(x, y, limit_w, txtHeight(qtLines(txt, limit_w, largura_blank), passoY) );
  popStyle();

  // desenha os parágrafos
  drawText (txt, limit_w, largura_blank, passoY, x, y+txtOffset(), debug);
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