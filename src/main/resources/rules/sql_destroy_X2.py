from rules.helpers_ps import deployed_helper_ps
from com.xebialabs.deployit.plugin.api.deployment.planning import Checkpoint

helper = deployed_helper_ps(previousDeployed, steps)
checkpoints = delta.intermediateCheckpoints


def should_execute_script(fname):
    is_checkpointed = helper.extract_checkpointname(fname) in checkpoints
    return not checkpoints or is_checkpointed


all_script_files = [ff for ff in helper.list_rollback_scripts() if should_execute_script(ff)]
# Sort reverse alphabetically
all_script_files.sort(reverse=True)

last_step = None
for script_file in all_script_files:
    last_step = helper.destroy_script_step(script_file)
    checkpoint = Checkpoint(delta._delegate, helper.extract_checkpointname(script_file), None)
    context.addStepWithCheckpoint(last_step, checkpoint)

if last_step:
    context.addCheckpoint(last_step, delta._delegate)
