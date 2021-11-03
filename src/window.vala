/* window.vala
 *
 * Copyright 2021 mr-chrome
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;

namespace Punteg {
	[GtkTemplate (ui = "/com/github/Punteg/window.ui")]
	public class Window : Gtk.ApplicationWindow {
		// Window globals
		[GtkChild]
		Gtk.Button open_btn;
		[GtkChild]
		Gtk.TextView output_textview;
		[GtkChild]
		Gtk.Button extract_btn;

    public Punteg.App application { get; construct; }
		public TextBuffer open_buffer;

		public signal void new_file ();

		// Get arguments and construct
		public Window (Punteg.App app) {
			Object (application: app);
		}

		construct {
			// widgets
			TextBuffer open_buffer = new TextBuffer (null);

			// actions
			open_btn.clicked.connect (on_open_btn_clicked);  // open
			extract_btn.clicked.connect (on_extract_btn_clicked);  // extract

			// callbacks
			this.new_file.connect (() => {
			application.read_file (application.my_file);
			application.main_loop.run ();

			if (application.file_text != null) {
				open_buffer.set_text (application.file_text);
			}

			output_textview.set_buffer (open_buffer);
			}); // new file signal
		}  // construct

		// Methods
		public void on_open_btn_clicked () {
      var file_chooser = new FileChooserDialog (
        "Open File",
        this,
        FileChooserAction.OPEN,
        "_Cancel", ResponseType.CANCEL,
        "_Open", ResponseType.ACCEPT
      );

      if (file_chooser.run () == ResponseType.ACCEPT) {
        open_file (file_chooser.get_filename ());
      }  // response accept

      file_chooser.destroy ();
    }  // on_add_button_clicked

		public void on_extract_btn_clicked () {
			TextBuffer extracted_buffer = new TextBuffer (null);
			extracted_buffer.text = application.extract_punctuation (application.my_file);

			output_textview.set_buffer (extracted_buffer);
		}

		public void open_file (string filename) {
        try {
            // string text;
            // application.my_file = GLib.FileUtils.get_contents (filename, out text);

            application.my_file = File.parse_name(filename);
						application.my_filename = filename;
      			stdout.printf("\n✔️ File loaded");
						new_file ();  // signal emission

        } catch (Error e) {
          /**
           * TODO! Raise a dialog to explain error
           */
            stderr.printf ("Error: %s\n", e.message);
        }
    }  // open_file

		// other stuff


	}  // Window
}  // namespace
