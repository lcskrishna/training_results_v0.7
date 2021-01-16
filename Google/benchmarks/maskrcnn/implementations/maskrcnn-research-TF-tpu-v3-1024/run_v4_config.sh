python3 mask_rcnn_main.py \
	    --eval_batch_size=8 \
	    --hparams=first_lr_drop_step=9750,second_lr_drop_step=13000 \
	    --model_dir=${MODEL_DIR} \
	    --num_epochs=1 \
	    --num_shards=8 \
	    --sleep_after_init=300 \
	    --train_batch_size=8 \
	    --training_file_pattern=${TRAIN_FILE_PATTERN} \
	    --val_json_file=${VAL_JSON_FILE} \
	    --validation_file_pattern=${EVAL_FILE_PATTERN} \
	    #--resnet_checkpoint=${RESNET_CHECKPOINT} \
	   # --hparams=
	    #--params_override="checkpoint=${RESNET_CHECKPOINT}, training_file_pattern=${TRAIN_FILE_PATTERN}, validation_file_pattern=${EVAL_FILE_PATTERN}, val_json_file=${VAL_JSON_FILE}" \
	    #	    --replicas_per_host=4 \
#
#	    --resnet_checkpoint=${RESNET_CHECKPOINT} \
