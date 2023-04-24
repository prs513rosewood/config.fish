# Infer python version
set python_version (python3 -V | cut -d " " -f 2 | cut -d '.' -f 1,2)

# Set paths
set LAMMPS_HOME "/opt/lammps"
#set -x PATH $LAMMPS_HOME/bin $PATH
#set -x PYTHONPATH "$LAMMPS_HOME/lib/python$python_version/site-packages:$PYTHONPATH"
#set -x LD_LIBRARY_PATH "$LAMMPS_HOME/lib:$LD_LIBRARY_PATH"
