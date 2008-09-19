/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#ifndef GTKPALUDIS_GUARD_LIBGTKPALUDIS_PACKAGES_REPOSITORY_FILTER_MODEL_HH
#define GTKPALUDIS_GUARD_LIBGTKPALUDIS_PACKAGES_REPOSITORY_FILTER_MODEL_HH 1

#include <gtkmm/treestore.h>
#include <paludis/util/private_implementation_pattern.hh>
#include <paludis/name.hh>
#include <paludis/generator.hh>
#include <tr1/memory>

namespace gtkpaludis
{
    class MainWindow;

    class PackagesRepositoryFilterModel :
        private paludis::PrivateImplementationPattern<PackagesRepositoryFilterModel>,
        public Gtk::TreeStore
    {
        protected:
            void populate_in_paludis_thread();
            void populate_in_gui_thread(const std::tr1::shared_ptr<const paludis::RepositoryNameSequence> & names);

        public:
            PackagesRepositoryFilterModel(MainWindow * const m);
            ~PackagesRepositoryFilterModel();

            void populate();

            class Columns :
                public Gtk::TreeModelColumnRecord
            {
                public:
                    Columns();
                    ~Columns();

                    Gtk::TreeModelColumn<bool> col_sensitive;
                    Gtk::TreeModelColumn<Glib::ustring> col_text;
                    Gtk::TreeModelColumn<std::tr1::shared_ptr<const paludis::Generator> > col_generator;
            };

            Columns & columns();
    };
}

#endif
