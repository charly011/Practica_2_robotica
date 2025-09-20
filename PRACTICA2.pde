import processing.serial.*;
Serial puerto;
float dato = 0.0, dato1 = 0.0;
String valor = "";
ArrayList<Float> graf1 = new ArrayList<Float>();
int max = 200;

void setup() {
  size(600, 400);   
  puerto = new Serial(this, "COM3", 115200);
  puerto.bufferUntil('\n');
}

void draw() {
  background(0);
  textSize(16);


  fill(255);
  text("Dato Original (0-4095): " + dato, 10, 20);

  fill(255);
  text("Dato Mapeado (1-50): " + dato1, 10, 60);

  noFill();
  stroke(100, 255, 255);
  stroke(0,0,255)
  float yMin = map(100, 15,40, height -10,100);
  line(0,yMin, width, yMin);
  beginShape();
  for (int i = 0; i < graf1.size(); i++) {
    float y = 200 - graf1.get(i) * 2;  
    vertex(i * (width / float(max)), y);
  }
  endShape();
}

void serialEvent(Serial puerto) {
  valor = puerto.readStringUntil('\n');
  if (valor != null) {
    dato = float(valor);
    dato1 = map(dato, 1, 4095, height -10, 100);

    graf1.add(dato1);
    if (graf1.size() > max) graf1.remove(0);
  }
}
