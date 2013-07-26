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

    for (int i = 0; i < canvases.length; i++) {
      if (canvas == canvases[i]) {
        controller.activeCanvases[i] = true;
        canvases[i].setRoutine(canvasRoutine);
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

      for (int i = 0; i < canvases.length; i++) {
        if (c0 == canvases[i]) {
          controller.activeCanvases[i] = true;
        }
        if (c1 == canvases[i]) {
          controller.activeCanvases[i] = true;
        }
      }
    }

    frameCounter--;

    c0.brightness -= framesInv;
    c1.brightness += framesInv;
 
    if (frameCounter <= 0) {
      c0.brightness = 0.0;
      c1.brightness = 1.0;
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
    println("DomeDisableCanvas");

    for (int i = 0; i < canvases.length; i++) {
      controller.activeCanvases[i] = false;
    }

    controller.next();
    controller.runDomeCode();
  }
}
