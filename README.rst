This folder contains configuration for the OpenRVDAS instance that collates and distributes data from the Air Sampling Lab on RSV Nuyina. It is a collaborative project between CSIRO and AAD. 
This instance is not required to do any data parsing, it is simply intended to collect information from a private network and redirect it to a place that the AAD can access it with their own acquisition system. 

To regenerate the config file if definitions change simply run

.. code-block:: bash
    . /opt/openrvdas/venv/bin/activate
    python3 config_generator.py