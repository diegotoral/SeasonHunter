// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2013 Diego Toral
 *
 * This software is licensed under the GNU General Public License
 * (version 3 or later). See the COPYING file in this distribution.
 *
 * You should have received a copy of the GNU Library General Public
 * License along with this software; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Authored by: Diego Toral <diegotoral@gmail.com>
 */

namespace SeasonHunter {
    public class SeasonHunter : Gtk.Application {
        private Gtk.ApplicationWindow m_window;

        private Settings settings;

        public SeasonHunter ()
        {

        }

        public override void activate ()
        {
            if (get_windows () == null)
            {
                // Load settings.
                this.settings = new Settings ("org.diegotoral.seasonhunter.preferences.window");

                this.m_window = new Gtk.ApplicationWindow (this);
                this.m_window.set_title ("SeasonHunter");
                this.m_window.set_default_size (
                    this.settings.get_int ("window-width"),
                    this.settings.get_int ("window-height")
                );

                this.m_window.show_all ();
            }
        }
    }
}
