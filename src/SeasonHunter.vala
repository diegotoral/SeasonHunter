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
    public class SeasonHunter : Granite.Application {

        private Gtk.Paned pane;
        private Gtk.Box main_container;
        private Gtk.ApplicationWindow m_window;

        private Widgets.Toolbar toolbar;
        private Widgets.SideBar sidebar;
        private Granite.Widgets.Welcome welcome;

        private Settings settings;

        construct {
            program_name = "SeasonHunter";
            exec_name = "seasonhunter";

            build_data_dir = Constants.DATADIR;
            build_pkg_data_dir = Constants.PKGDATADIR;
            build_version = Constants.VERSION;

            app_years = "2013";
            app_icon = "applications-chat";
            app_launcher = "seasonhunter.desktop";
            application_id = "com.github.seasonhunter";

            main_url = "https://github.com/diegotoral/SeasonHunter";
            bug_url = "https://github.com/diegotoral/SeasonHunter/issues";
            help_url = "https://github.com/diegotoral/SeasonHunter/wiki";
            translate_url = "https://github.com/diegotoral/SeasonHunter";

            about_authors = {"Diego Toral <diegotoral@gmail.com>"};
            about_documenters = {"Diego Toral <diegotoral@gmail.com>"};
            about_artists = {""};
            about_comments = "Development release, not all features implemented";
            about_translators = "";
            about_license_type = Gtk.License.GPL_3_0;
        }

        public SeasonHunter ()
        {
            Granite.Services.Logger.initialize ("SeasonHunter");
            Granite.Services.Logger.DisplayLevel = Granite.Services.LogLevel.DEBUG;
        }

        public override void activate ()
        {
            if (get_windows () == null)
            {
                settings = new Settings ();
                toolbar = new Widgets.Toolbar (this);
                sidebar = new Widgets.SideBar (settings);
                pane =  new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
                main_container = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);

                // Window configuration
                m_window = new Gtk.ApplicationWindow (this);
                m_window.set_title ("SeasonHunter");
                m_window.height_request = 600;
                m_window.width_request = 1100;
                m_window.window_position = Gtk.WindowPosition.CENTER;

                // Set the window size based on saved settings
                m_window.set_default_size (
                    settings.window_width,
                    settings.window_height
                );

                // Pane configuration
                pane.set_position (settings.sidebar_width);

                main_container.pack_start (toolbar, false);
                main_container.pack_end (pane, true);

                pane.add1 (sidebar);

                show_welcome ();

                m_window.add (main_container);
                m_window.show_all ();
            }
        }

        public void show_welcome ()
        {
            // Create the welcome widget.
            welcome = new Granite.Widgets.Welcome (
                _("Welcome to SeasonHunter"),
                _("A lightweight TV tracker")
            );

            // Append buttons.
            welcome.append (Gtk.Stock.FIND, _("Find a show"), _("Search for a show to add to your collection"));

            pane.add2 (welcome);
        }
    }
}
