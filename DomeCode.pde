class DomeCode {
  CanvasRoutineController controller;

  DomeCode() { }
  void run() { }
}

class DomeSetCanvas extends DomeCode {
  Canvas canvas;
  CanvasRoutine canvasRoutine;

  DomeSetCanvas(CanvasRoutineController controller_, Canvas canvas_, CanvasRoutine canvasRoutine_) {
    controller = controller_;
    canvas = canvas_;
    canvasRoutine = canvasRoutine_;
  }

  void run() {
    canvas.brightness = 1.0;

    for (int i = 0; i < controller.nCanvases; i++) {
      if (canvas == canvases[i]) {
        controller.activeCanvases[i] = true;
        canvases[i].setRoutine(canvasRoutine);
      }
    }

    controller.next();
    controller.runDomeCode();
  }
}

class DomePushCanvas extends DomeCode {
  Canvas canvas;
  CanvasRoutine canvasRoutine;

  DomePushCanvas(CanvasRoutineController controller_, Canvas canvas_, CanvasRoutine canvasRoutine_) {
    controller = controller_;
    canvas = canvas_;
    canvasRoutine = canvasRoutine_;
  }

  void run() {
    canvas.brightness = 1.0;

    for (int i = 0; i < canvases.length; i++) {
      if (canvas == canvases[i]) {
        controller.activeCanvases[i] = true;
        canvases[i].pushRoutine(canvasRoutine);
        break;
      } 
    }

    controller.next();
    controller.runDomeCode();
  }
}

class DomePopCanvas extends DomeCode {
  Canvas canvas;

  DomePopCanvas(CanvasRoutineController controller_, Canvas canvas_) {
    controller = controller_;
    canvas = canvas_;
  }

  void run() {
    for (int i = 0; i < canvases.length; i++) {
      if (canvas == canvases[i]) {
        canvases[i].popRoutine();
        break;
      } 
    }

    controller.next();
    controller.runDomeCode();
  }
}

class DomeWait extends DomeCode {
  int frames;
  int frameCounter;
  boolean isInitialized = false;

  DomeWait(CanvasRoutineController controller_, int frames_) {
    controller = controller_;
    frames = frames_;
  }
  
  void run() {
    if (!isInitialized) {
      init();
    }

    frameCounter--;

    if (frameCounter <= 0) {
      end();
      controller.next();
    }
  }

  void init() {
    isInitialized = true;
    frameCounter = frames;
  }

  void end() {
    isInitialized = false;
  }
}

class DomeCrossfade extends DomeCode {
  Canvas c0;
  Canvas c1;
  int frames;
  float framesInv;
  int frameCounter;
  boolean isInitialized = false;

  DomeCrossfade(CanvasRoutineController controller_, int frames_, Canvas c0_, Canvas c1_) {
    controller = controller_;
    frames = frames_;
    framesInv = 1.0 / frames;
    c0 = c0_;
    c1 = c1_;
  }

  void run() {
    if (!isInitialized) {
      init();
      c0.brightness = 1.0;
      c1.brightness = 0.0;

    }

    frameCounter--;

    c0.brightness -= framesInv;
    c1.brightness += framesInv;
 
    if (frameCounter <= 0) {
      c0.brightness = 0.0;
      c1.brightness = 1.0;
      end();
      controller.next();

      for (int i = 0; i < canvases.length; i++) {
        if (c0 == canvases[i]) {
          controller.activeCanvases[i] = false;
          break;
        }
      }
    }
  }

  void init() {
    isInitialized = true;
    frameCounter = frames;

    for (int i = 0; i < canvases.length; i++) {
      if (c0 == canvases[i]) {
        controller.activeCanvases[i] = true;
      }
      if (c1 == canvases[i]) {
        controller.activeCanvases[i] = true;
      }
    }
  }

  void end() {
    isInitialized = false;
  }
}

class DomeFadeIn extends DomeCode {
  Canvas canvas;
  int frames;
  float framesInv;
  int frameCounter;
  boolean isInitialized = false;

  DomeFadeIn(CanvasRoutineController controller_, int frames_, Canvas canvas_) {
    controller = controller_;
    frames = frames_;
    framesInv = 1.0 / frames;
    canvas = canvas_;
  }

  void run() {
    if (!isInitialized) {
      init();
      canvas.brightness = 0.0;
    }

    frameCounter--;

    canvas.brightness += framesInv;
 
    if (frameCounter <= 0) {
      canvas.brightness = 1.0;
      end();
      controller.next();
    }
  }

  void init() {
    isInitialized = true;
    frameCounter = frames;

    for (int i = 0; i < canvases.length; i++) {
      if (canvas == canvases[i]) {
        controller.activeCanvases[i] = true;
        break;
      }
    }
  }

  void end() {
    isInitialized = false;
  }
}

class DomeFadeOut extends DomeCode {
  Canvas canvas;
  int frames;
  float framesInv;
  int frameCounter;
  boolean isInitialized = false;

  DomeFadeOut(CanvasRoutineController controller_, int frames_, Canvas canvas_) {
    controller = controller_;
    frames = frames_;
    framesInv = 1.0 / frames;
    canvas = canvas_;
  }

  void run() {
    if (!isInitialized) {
      init();
      canvas.brightness = 1.0;
    }

    frameCounter--;

    canvas.brightness -= framesInv;
 
    if (frameCounter <= 0) {
      canvas.brightness = 0.0;
      end();
      controller.next();

      for (int i = 0; i < canvases.length; i++) {
        if (canvas == canvases[i]) {
          controller.activeCanvases[i] = false;
          break;
        }
      }
    }
  }

  void init() {
    isInitialized = true;
    frameCounter = frames;

    for (int i = 0; i < canvases.length; i++) {
      if (canvas == canvases[i]) {
        controller.activeCanvases[i] = true;
        break;
      }
    }
  }

  void end() {
    isInitialized = false;
  }
}
class DomeEnableCanvas extends DomeCode {
  Canvas canvas;

  DomeEnableCanvas(CanvasRoutineController controller_, Canvas canvas_) {
    controller = controller_;
    canvas = canvas_;
  }

  void run() {
    for (int i = 0; i < canvases.length; i++) {
      if (canvas == canvases[i]) {
        controller.activeCanvases[i] = true;
        break;
      } 
    }

    controller.next();
    controller.runDomeCode();
  }
}

class DomeDisableCanvas extends DomeCode {
  Canvas canvas;

  DomeDisableCanvas(CanvasRoutineController controller_, Canvas canvas_) {
    controller = controller_;
    canvas = canvas_;
  }

  void run() {
    for (int i = 0; i < controller.nCanvases; i++) {
      if (canvas == canvases[i]) {
        controller.activeCanvases[i] = false;
        break;
      }
    }

    controller.next();
    controller.runDomeCode();
  }
}

class DomeDisableCanvases extends DomeCode {
  DomeDisableCanvases(CanvasRoutineController controller_) {
    controller = controller_;
  }

  void run() {
    for (int i = 0; i < controller.nCanvases; i++) {
      controller.activeCanvases[i] = false;
    }

    controller.next();
    controller.runDomeCode();
  }
}

class DomeSetModFloat extends DomeCode {
  ModFloat m;
  float v;

  DomeSetModFloat(CanvasRoutineController controller_, ModFloat m_, float v_) {
    controller = controller_;
    m = m_;
    v = v_;
  }

  void run() {
    m.set(v);
    controller.next();
    controller.runDomeCode();
  }
}

class DomeSetModColor extends DomeCode {
  ModColor c;
  color v;

  DomeSetModColor(CanvasRoutineController controller_, ModColor c_, color v_) {
    controller = controller_;
    c = c_;
    v = v_;
  }

  void run() {
    c.set(v);
    controller.next();
    controller.runDomeCode();
  }
}

class DomeLine extends DomeCode {
  ModLine modLine;

  DomeLine(CanvasRoutineController controller_, ModLine modLine_) {
    controller = controller_;
    modLine = modLine_;
  }

  void run() {
    modLine.init();
    controller.modEvents.add(modLine);  
    controller.next();
    controller.runDomeCode();
  }
}
