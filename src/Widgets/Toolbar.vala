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

 namespace SeasonHunter.Widgets {
    public class Toolbar : Gtk.Toolbar {

        public Gtk.Menu menu;
        public Granite.Widgets.AppMenu app_menu;

        public Toolbar (Granite.Application ?app)
        {
            get_style_context ().add_class ("primary-toolbar");

            menu = new Gtk.Menu ();
            app_menu = app.create_appmenu (menu);

            add (menu);
            add_spacer ();
            add (app_menu);

            show_all ();
        }

        private void add_spacer ()
        {
            var spacer = new Gtk.ToolItem ();
            spacer.set_expand (true);
            add (spacer);
        }
    }
 }
