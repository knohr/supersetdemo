FROM apache/superset
USER root
RUN pip install authlib==1.2.0
#ADD --chown=superset:superset ./superset_config.py /app/pythonpath/
#ADD --chown=superset:superset ./custom_sso_security_manager.py /app/pythonpath_dev/
ENV SUPERSET_SECRET_KEY sosecret
RUN superset fab create-admin \
              --username admin \
              --firstname Superset \
              --lastname Admin \
              --email admin@superset.com \
              --password admin

USER superset
