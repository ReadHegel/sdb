import hydra
from omegaconf import DictConfig, OmegaConf


from hydra.utils import call


@hydra.main(version_base = None, config_path = "../configs", config_name = "config")
def main(config: DictConfig):
    print(f"Config:\n{OmegaConf.to_yaml(config)}")
    call(config.exp.run_func, config)

if __name__ == "__main__":
    main()
