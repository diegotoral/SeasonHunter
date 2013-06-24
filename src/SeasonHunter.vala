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

        private Gtk.Box container;
        private Gtk.Toolbar toolbar;
        private Gtk.ApplicationWindow m_window;
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
                // Load settings.
                settings = new Settings ();

                m_window = new Gtk.ApplicationWindow (this);
                m_window.set_title ("SeasonHunter");
                m_window.set_default_size (
                    settings.window_width,
                    settings.window_height
                );

                container = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);

                build_toolbar ();

                show_welcome ();

                m_window.add (container);
                m_window.show_all ();
            }
        }

        public void build_toolbar ()
        {
            var menu = new Gtk.Menu();
            toolbar = new Gtk.Toolbar();
            Granite.Widgets.AppMenu app_menu = create_appmenu (menu);

            toolbar.add (app_menu);

            container.pack_start (toolbar, false);
        }

        public void show_welcome ()
        {
            // Create the welcome widget.
            welcome = new Granite.Widgets.Welcome (
                _("Welcome to SeasonHunter"),
                _("A lightweight TV tracker")
            );

            // Append buttons.
            welcome.append ("icon-name", "Search a show", "Search for a show to add to your collection");

            container.pack_end (welcome, true, true, 0);
        }
    }
}
