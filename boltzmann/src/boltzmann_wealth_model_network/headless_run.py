from .model import BoltzmannWealthModelNetwork

if __name__ == '__main__':
   bwmn = BoltzmannWealthModelNetwork()
   bwmn.run_model(10)
   bwmn.datacollector.get_model_vars_dataframe().to_csv('/app/data/model.csv')
   bwmn.datacollector.get_agent_vars_dataframe().to_csv('/app/data/agents.csv')
