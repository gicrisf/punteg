punteg_sources = [
  'main.vala',
  'Application.vala',
  'window.vala',
]

punteg_deps = [
  dependency('gio-2.0', version: '>= 2.50'),
  dependency('gtk+-3.0', version: '>= 3.22'),
]

gnome = import('gnome')

punteg_sources += gnome.compile_resources('punteg-resources',
  'punteg.gresource.xml',
  c_name: 'punteg'
)

executable('punteg', punteg_sources,
  vala_args: '--target-glib=2.50',  dependencies: punteg_deps,
  install: true,
)
