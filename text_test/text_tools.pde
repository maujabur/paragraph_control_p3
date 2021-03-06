// MIT License
// Copyright (c) 2016 maujaburPFont fonte; 
// 2016/12/21
// Processing 3.2.3

// breaks the text into words
String[] breakTxt (String txt) {
  return txt.split("\\s++"); // breaks on spaces, one or more
}

// calculates the width for a text starting on [beginIndex] inclusive
// and ending on [endIndex] exclusive
float widthText (String[] words, int beginIndex, int endIndex, float blank_w) {
  float w = 0;
  for (int i = beginIndex; i <endIndex; i++) {
    w += textWidth(words[i])+blank_w;
  }
  if (w>0) {
    w -= blank_w;
  }
  return w;
}

// gets the index for the next break, given certain text maximum width
int getIindex(String[] words, int first, float txt_w, float blank_w) {
  int result = first;
  float w = 0;

  while (result < words.length) {
    if (result > first) {
      w += blank_w;
    }
    w += textWidth(words[result]);
    if (w >= txt_w) break;
    result++;
  };
  if (result == first) result++;
  return result;
}

// makes a list of the breaks for certain text maximum width
IntList getBreaks(String[] words, float txt_w, float blank_w) {
  IntList result = new IntList();
  result.append(0);

  int index=0;
  while (index < words.length) {
    index = getIindex(words, index, txt_w, blank_w);
    result.append(index);
  }
  return result;
}

// draws the text starting on [beginIndex] inclusive
// and ending on [endIndex] exclusive
// returns the width of the rendered text
float drawText (String[] words, int beginIndex, int endIndex, float blank_w, float x, float y, boolean debug) {
  float w = 0;
  for (int i = beginIndex; i <endIndex; i++) {
    text (words[i], x+w, y);
    w += textWidth(words[i])+blank_w;
  }
  if (w>0) {
    w -= blank_w;
  }
  if (debug) {
    pushStyle();
    stroke (0, 0, 255);
    line (x, y-fontSize*fontLeading, x, y);
    stroke (255, 0, 0);
    line (x+w, y-fontSize+textDescent(), x+w, y+textDescent());
    stroke (120, 120, 120);
    line(x, y, x+w, y);
    stroke (255, 0, 255);
    line(x, y+textDescent(), x+w, y+textDescent());
    stroke (0, 255, 255);
    line(x, y+textDescent()-textAscent(), x+w, y+textDescent()-textAscent());
    popStyle();
  }
  return w;
}

int drawTextByW (String[] words, int beginIndex, float txt_w, float blank_w, float x, float y, boolean debug) {
  int endIndex = getIindex(words, beginIndex, txt_w, blank_w);
  drawText (words, beginIndex, endIndex, blank_w, x, y, debug);
  return endIndex;
}

// draws a paragraph given the list of words and the list of breaks
// returns the y coordinate of the last line rendered
float drawParagraph(String[] words, IntList breaks, float blank_w, float yStep, float x, float y, boolean debug) {
  for (int i = 1; i< breaks.size(); i++) {
    float w = drawText (words, breaks.get(i-1), breaks.get(i), blank_w, x, y, debug);
    if (debug) {
      pushStyle();
      fill(255, 0, 0);
      String debugTXT= "<" + nf(limit_w-w, 0, 1);
      text (debugTXT, x+w, y);
      fill(255, 255, 0);
      text (" ["+ breaks.get(i)+ "]", x+w+textWidth(debugTXT), y);
      popStyle();
    }
    y += yStep;
  }
  return y;
}

float drawParagraphByW(String txt, float txt_w, float blank_w, float yStep, float x, float y, boolean debug) {
  String[] words = breakTxt(txt);
  IntList breaks = getBreaks(words, txt_w, blank_w);
  return drawParagraph(words, breaks, blank_w, yStep, x, y, debug);
}

float txtOffset() {
  return textAscent()-textDescent();
}

float txtHeight(int qtLines, float yStep) {
  return  (qtLines-1)*yStep+textAscent();
}

String[] breakParagraphs(String txt) {
  return txt.split("\n");
}

int qtLines(String txt, float txt_w, float blank_w) {
int result = 0;
  String[] paragraphs = breakParagraphs(txt);
  for (int i = 0; i< paragraphs.length; i++) {
    String[] words = breakTxt (paragraphs[i]); 
    result += getBreaks(words, txt_w, blank_w).size()-1;
  }
  return result;
}

float drawText(String txt, float txt_w, float blank_w, float yStep, float x, float y, boolean debug) {
  String[] paragraphs = breakParagraphs(txt);
  for (int i = 0; i< paragraphs.length; i++) {
    y = drawParagraphByW(paragraphs[i], txt_w, blank_w, yStep, x, y, debug);
  }

  return y;
}