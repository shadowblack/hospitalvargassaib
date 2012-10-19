<?php

?>
<h2><?php echo $data["name"]; ?></h2>
<p class="error">
	<strong><?php __('Error'); ?>: </strong>
	<?php printf(__('La Sessión %s', true), "<strong>'".$data["message"]."'</strong>"); ?>
</p>