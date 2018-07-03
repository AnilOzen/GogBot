class Animation {
  int tmr = 0;
  int tmrRst = 0;
  boolean ani1bool = true;
  boolean ani2bool = true;

  boolean a1=true;
  boolean a2=false;

  int t = 5;

  void run() {
    colorMode(RGB);
    tmr = millis()-tmrRst;

    if (a1) {
      if (tmr<34000) ani0();
      if (tmr>34000 && tmr<38000) ani1(tmr-34000, 38000-tmr);
      if (tmr>38500 && tmr<42000) ani2(tmr-38500, 42000-tmr);
      if (tmr>47000 && tmr<50000) ani3();
      if (tmr>51000) a1=false;
    }

    if (sound.introBool && !a2) {
      reset();
      a2 = true;
    }

    if (a2) {
      if (tmr<6000) ani4();
      if (tmr>8000 && tmr<10000) ani5(tmr-8000, 10000-tmr);
      if (tmr>13000 && tmr<18000) ani8(tmr-13000, 18000-tmr);
      if (tmr>24000 && tmr<30000) ani6(tmr-24000, 30000-tmr);
      if (tmr>34000 && tmr<37000) ani7(tmr-34000, 37000-tmr);
    }
  }

  void ani0() {
    for (int i=0; i<t; i++) {
      if (frameCount % 50 < 25) communication.commandArduino(i, 1, 255, 0, 0);
      else communication.commandArduino(i, 1, 0, 0, 0);
    }
  }

  void ani1(int m, int n) {
    if (ani1bool) {
      for (int i=0; i<t; i++) {
        communication.commandArduino(i, 1, 0, 0, 0);
      }
      ani1bool = false;
    }
    for (int i=0; i<constrain(floor(map(m, 0, n, 0, t)), 0, t); i++) {
      communication.commandArduino(i, 1, 255, 255, 255);
    }
  }

  void ani2(int m, int n) {
    float k = map(m, 0, n, 0, 1);
    for (int i=0; i<t; i++) {
      color c = network.brains.get(i).clr;
      c = lerpColor(color(255, 255, 255), c, k);
      communication.commandArduino(i, 1, int(red(c)), int(green(c)), int(blue(c)));
    }
  }

  void ani3() {
    for (int i=0; i<t; i++) {
      if (i==1 || i==2 || i==3) communication.commandArduino(i, 1, (int)red(network.brains.get(i).clr), (int)green(network.brains.get(i).clr), (int)blue(network.brains.get(i).clr));
      else communication.commandArduino(i, 2, 255, 255, 255);
    }
  }

  void ani4() {
    if (tmr<500) for (int i=0; i<t; i++) {
      if (i==1 || i==2 || i==3) communication.commandArduino(i, 1, (int)red(network.brains.get(i).clr)/2, (int)green(network.brains.get(i).clr)/2, (int)blue(network.brains.get(i).clr)/2);
      else communication.commandArduino(i, 2, 255, 255, 255);
    }
    if (tmr>500 && tmr<2000) for (int i=0; i<t; i++) {
      float amp = random(1, 5);
      if (i==1) communication.commandArduino(i, 1, int(red(network.brains.get(i).clr)/amp), int(green(network.brains.get(i).clr)/amp), int(blue(network.brains.get(i).clr)/amp));
      if (i==2 || i==3) communication.commandArduino(i, 1, (int)red(network.brains.get(i).clr)/2, (int)green(network.brains.get(i).clr)/2, (int)blue(network.brains.get(i).clr)/2);
      if (i==4 || i==5) communication.commandArduino(i, 2, 255, 255, 255);
    }
    if (tmr>2000 && tmr<3500) for (int i=0; i<t; i++) {
      float amp = random(1, 5);
      if (i==2) communication.commandArduino(i, 1, int(red(network.brains.get(i).clr)/amp), int(green(network.brains.get(i).clr)/amp), int(blue(network.brains.get(i).clr)/amp));
      if (i==1 || i==3) communication.commandArduino(i, 1, (int)red(network.brains.get(i).clr)/2, (int)green(network.brains.get(i).clr)/2, (int)blue(network.brains.get(i).clr)/2);
      if (i==4 || i==5) communication.commandArduino(i, 2, 255, 255, 255);
    }
    if (tmr>3500 && tmr<5000) for (int i=0; i<t; i++) {
      float amp = random(1, 5);
      if (i==3) communication.commandArduino(i, 1, int(red(network.brains.get(i).clr)/amp), int(green(network.brains.get(i).clr)/amp), int(blue(network.brains.get(i).clr)/amp));
      if (i==2 || i==1) communication.commandArduino(i, 1, (int)red(network.brains.get(i).clr)/2, (int)green(network.brains.get(i).clr)/2, (int)blue(network.brains.get(i).clr)/2);
      if (i==4 || i==5) communication.commandArduino(i, 2, 255, 255, 255);
    }
  }

  void ani5(int m, int n) {
    float k = map(m, 0, n, 0, 1);

    for (int i=0; i<t; i++) {
      color c = lerpColor(network.brains.get(i).clr, color(255, 255, 0), k);
      if (i==1 || i==2 || i==3) communication.commandArduino(i, 1, (int)red(c), (int)green(c), (int)blue(c));
      else communication.commandArduino(i, 2, 255, 255, 255);
    }
  }

  void ani6(int m, int n) {
    float k = map(m, 0, n, 0, 4);
    if (k<1) {
      color c = lerpColor(color(255, 0, 0), color(255, 255, 0), k);
      for (int i=0; i<t; i++) communication.commandArduino(i, 1, (int)red(c), (int)green(c), (int)blue(c));
    }
    if (k>1 && k<2) {
      color c = lerpColor(color(255, 255, 0), color(0, 0, 255), k-1);
      for (int i=0; i<t; i++) communication.commandArduino(i, 1, (int)red(c), (int)green(c), (int)blue(c));
    }
    if (k>2 && k<3) {
      color c = lerpColor(color(0, 0, 255), color(0, 255, 0), k-2);
      for (int i=0; i<t; i++) communication.commandArduino(i, 1, (int)red(c), (int)green(c), (int)blue(c));
    }
    if (k>3 && k<4) {
      color c = lerpColor(color(0, 255, 0), color(255, 0, 255), k-3);
      for (int i=0; i<t; i++) communication.commandArduino(i, 1, (int)red(c), (int)green(c), (int)blue(c));
    }
  }

  void ani7(int m, int n) {
    float k = map(m, 0, n, 0, 1);
    for (int i=0; i<t; i++) {
      color c = network.brains.get(i).clr;
      c = lerpColor(color(255, 255, 255), c, k);
      communication.commandArduino(i, 1, int(red(c)), int(green(c)), int(blue(c)));
    }
  }

  void ani8(int m, int n) {
    float k = map(m, 0, n, 0, 1);
    if (k<1) {
      for (int i=0; i<t; i++) {
        color c = network.brains.get(i).clr;
        if ( i== 0 || i == 2 || i==4) communication.commandArduino(i, 1, (int)red(c), (int)green(c), (int)blue(c));
        else communication.commandArduino(i, 2, 255, 255, 255);
      }
    }
    if (k>1 && k<2) {
      for (int i=0; i<t; i++) {
        color c = network.brains.get(i).clr;
        c = lerpColor(color(0, 0, 255), c, k);
        communication.commandArduino(i, 1, int(red(c)), int(green(c)), int(blue(c)));
      }
    }
    if (k>2 && k<3) {
      color c = lerpColor(color(0, 0, 255), color(0, 255, 0), k-2);
      for (int i=0; i<t; i++) communication.commandArduino(i, 1, (int)red(c), (int)green(c), (int)blue(c));
    }
    if (k>3 && k<4) {
      color c = lerpColor(color(0, 255, 0), color(255, 0, 255), k-3);
      for (int i=0; i<t; i++) communication.commandArduino(i, 1, (int)red(c), (int)green(c), (int)blue(c));
    }
  }

  void reset() {
    tmrRst = millis();
  }

  void finito() {
    for (int i=0; i<t; i++) {
      if (network.getTotalPoints()>1) communication.commandArduino(i, 1, 255, 0, 255);
      if (network.getTotalPoints()<-1) communication.commandArduino(i, 1, 255, 0, 0);
      if (network.getTotalPoints()>=-1 && network.getTotalPoints()<=1) communication.commandArduino(i, 1, 0, 0, 255);
    }
  }
}
