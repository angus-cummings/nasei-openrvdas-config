This folder contains configuration for the OpenRVDAS instance that collates and distributes data from the Air Sampling Lab on RSV Nuyina. It is a collaborative project between CSIRO and AAD. 
This instance is not required to do any data parsing, it is simply intended to collect information from a private network and redirect it to a place that the AAD can access it with their own acquisition system. 

The whole config can be deployed using :code:`setup.sh`, which:

  #. Installs OS dependencies (git)
  #. Deploys the tmpfiles configuration (cleans log files older than the specified days)
  #. Runs DPCs OpenRVDAS setup
  #. Simlinks the nasei configuration into the OpenRVDAS local dir
  #. Uses OpenRVDAS API to deploy the OpenRVDAS config from local
  #. Opens Firefox to localhost

Variables for jinja templates are configurable within :code:`nasei-openrvdas-config/nasei_port_definitions.yaml` 

+--------------------+--------------------+
| Variable           | Default Value      |
+====================+====================+
| file_root          |   /data/raw/       |
+--------------------+--------------------+
| file_endurance     | 365d               |
+--------------------+--------------------+
| AAD_broadcast_ip   | 172.16.29.255      |
+--------------------+--------------------+
| AAD_broadcast_port | AAD_broadcast_port |
+--------------------+--------------------+


Device names and broadcast ports are also defined within this file, and as new information becomes available the port definitions should be completed and moved from the :code:`incomplete` dict to the :code:`devices` key. 

.. code-block:: yaml

  incomplete:
    # Aerosol Manifold Water Detector
    aerosol_manifold_water_detector:
      port: 
      source: 192.168.0.120 
    # GHG Manifold Water Detector
    ghg_manifold_water_detector:
      port: 
      source: 192.168.0.120

To regenerate the config file if definitions change simply run:

.. code-block:: bash

    . /opt/openrvdas/venv/bin/activate
    pip install jinja2 yaml
    python3 config_generator.py

******
TODOS:
******

 * configure /data access for AADC, AAD Tech Services to facilitate
 * CSIRO-SIT want to be able to drive devices within their network to switch instruments up
