#/bin/sh


echo_format() {
    echo "============================================================"
    echo "$1"
    echo "============================================================"
}


echo_format "Generating indexes"
/opt/idea/bin/${IDE_SHORT}.sh dump-shared-index project \
    --project-dir=${IDEA_PROJECT_DIR} \
    --project-id=${PROJECT_ID} \
    --commit-id=${COMMIT_ID} \
    --tmp=${SHARED_INDEX_BASE}/temp \
    --output=${SHARED_INDEX_BASE}/output

echo_format "Formatting indexes"
/opt/cdn-layout-tool/bin/cdn-layout-tool \
    --indexes-dir=${SHARED_INDEX_BASE} \
    --url=${INDEXES_CDN_URL} && \
    mv ${SHARED_INDEX_BASE}/output ${SHARED_INDEX_BASE}/project/output

# Create config file in project folder, or update if it already exists
echo_format "Creating intellij.yaml file"
if [ -f "$IDEA_PROJECT_DIR/intellij.yaml" ]; then
    echo "Your project already has an intellij.yaml file. Be sure to add the following to it:"
else 
    echo "Creating $FILE"
    echo "indexes_url: ${INDEXES_CDN_URL}" > $IDEA_PROJECT_DIR/intellij.yaml
fi