namespace Punteg {

  public class App : Gtk.Application {

    // Global variables
    public Window window { get; private set; default = null; }
    public string my_filename;
    public GLib.File my_file;
    public string file_text;
    public MainLoop main_loop;

    construct {
      application_id = "com.github.Punteg";
      flags = ApplicationFlags.FLAGS_NONE;

      main_loop = new MainLoop ();
    }

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

  /**
  * originally inspired from: https://stackoverflow.com/a/3063796
  *
  * Docs:
  * https://wiki.gnome.org/Projects/Vala/StringSample
  * https://valadoc.org/gio-2.0/GLib.File.read.html
  */
  public string extract_punctuation (File f) {
    FileInputStream input_s = f.read ();
    DataInputStream dinput_s = new DataInputStream (input_s);
    string line;

    var sb = new GLib.StringBuilder ();
    var sb_out = new GLib.StringBuilder ();

    while ((line = dinput_s.read_line ()) != null) {
      unichar c;
      for (int i = 0; line.get_next_char (ref i, out c);) {
        if (c.ispunct()) {
          sb_out.append (c.to_string());
          // stdout.printf(c.to_string());
        }  // if punct
      }

      sb.append (line);
		}

    return sb_out.str;
  }  // extract_punctuation

  /**
   * Made possible by the documentation.
   * For a future me or anyone else interested:
   * Look here for a simple async implementation!
   *
   * https://wiki.gnome.org/Projects/Vala/GIOSamples
   */
  public async void read_file (File f) {
			var text = new StringBuilder ();

			try {
				var dis = new DataInputStream (f.read ());
				string line;

				while ((line = yield dis.read_line_async (Priority.DEFAULT)) != null) {
					text.append (line);
					text.append_c ('\n');
				}

				// print (text.str);  // debug function
        this.file_text = text.str;
			} catch (Error e) {
				error (e.message);
			}

      this.main_loop.quit ();
		}  // read_file function

  } // PuntegApp
}  // namespace
