namespace Punteg {

  public class App : Gtk.Application {

    construct {
      application_id = "com.github.Punteg";
      flags = ApplicationFlags.FLAGS_NONE;
    }

    // Global variables
    public Window window { get; private set; default = null; }
    public GLib.File my_file;

    // Methods
    protected override void activate () {
      stdout.printf("\n✔️ Activated");

      if (this.window == null) {
        this.window = new Window (this);
        this.window.set_application (this);
      }  // if no window

      if (this.window != null) {
        this.window.show_all ();
      }  // if window

    }  // activate

  public get_punctuation (line) {
    /*
     * TODO get punctuation from a single line of the file
     * return it
     */
  }  // get_punctuation

  } // PuntegApp
}  // namespace
