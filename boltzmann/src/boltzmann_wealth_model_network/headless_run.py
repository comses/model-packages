import sys
from .model import BoltzmannWealthModelNetwork

if __name__ == '__main__':
   assert len(sys.argv) == 2, 'Must specify a run name'
   run_name = sys.argv[1]
   bwmn = BoltzmannWealthModelNetwork()
   bwmn.run_model(10)
   bwmn.datacollector.get_model_vars_dataframe().to_csv(f'/app/data/{run_name}_model.csv')
   bwmn.datacollector.get_agent_vars_dataframe().to_csv(f'/app/data/{run_name}_agents.csv')
