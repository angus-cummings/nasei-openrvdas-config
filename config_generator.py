import yaml
import jinja2

def raise_helper(msg):
    raise Exception(msg)

if __name__ == '__main__':
    env = jinja2.Environment(trim_blocks=True, lstrip_blocks=True, loader=jinja2.FileSystemLoader(searchpath="."))
    env.globals['raise'] = raise_helper

    with open('nasei_port_definitions.yaml') as f:
        data = yaml.load(f, Loader=yaml.FullLoader)

    template = env.get_template('template.jinja')

    config = template.render(data)

    with open('config.yaml', 'w') as f:
        f.write(config)