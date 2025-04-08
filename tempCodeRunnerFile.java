public class Disable_interrupt {
    private static volatile boolean interruptDisabled = false;
   
    public static void criticalSection() {
        while (interruptDisabled) {
            System.out.println("In Critical Section");
            try {
                Thread.sleep(100); 
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
    public static void disableInterrupts() {
        interruptDisabled = true;
        System.out.println("Interrupts Disabled. Entering Critical Section.");
    }
    public static void enableInterrupts() {
        interruptDisabled = false;
        System.out.println("Interrupts Enabled. Leaving Critical Section.");
    }
     public static void main(String[] args) {
        Thread worker = new Thread(() -> Disable_interrupt.criticalSection());
        worker.start();
        disableInterrupts(); 
        try {
            Thread.sleep(2000); 
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        enableInterrupts();
    }
}
