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

    public Punteg.App application { get; construct; }

		// Get arguments and construct
		public Window (Punteg.App app) {
			Object (application: app);
		}

		construct {
			open_btn.clicked.connect (on_open_btn_clicked);  // open_btn
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

		private void open_file (string filename) {
        try {
            // string text;
            // GLib.FileUtils.get_contents (filename, out text);

            application.my_file = File.parse_name(filename);
      			stdout.printf("\n✔️ File loaded");

        } catch (Error e) {
          /**
           * TODO! Raise a dialog to explain error
           */
            stderr.printf ("Error: %s\n", e.message);
        }
    }  // open_file

	}  // Window
}  // namespace
