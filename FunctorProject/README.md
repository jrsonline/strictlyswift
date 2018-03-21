#  README

This project uses Sourcery as a Podfile.  I have set up a build phase to turn the '.stencil' file into generated Swift code. The output file is placed into the FunctorProject/HKT directory.

Note that the ordering of the generated sourcery.generated.swift file is key -- it needs to be placed in the Build Phases so that it compiles before any of the files using the created classes. This project already has that set up.
