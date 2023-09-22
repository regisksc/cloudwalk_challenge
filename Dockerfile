FROM ghcr.io/cirruslabs/flutter:3.13.5

WORKDIR /cloudwalk

COPY . /cloudwalk

RUN dart pub global activate melos

RUN dart pub global activate dart_code_metrics

ENV PATH="$PATH:/root/.pub-cache/bin"

RUN mkdir /opt/android-sdk && \
    wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O android-sdk.zip && \
    unzip -q android-sdk.zip -d /opt/android-sdk && \
    rm android-sdk.zip

ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV PATH="$PATH:$ANDROID_SDK_ROOT/tools/bin"

RUN yes | sdkmanager --licenses

RUN sdkmanager "system-images;android-29;google_apis;x86_64" && \
    avdmanager create avd -n emulator -k "system-images;android-29;google_apis;x86_64" && \
    emulator -avd emulator -no-audio -no-window -gpu swiftshader -qemu -vnc :1 

RUN melos bootstrap

RUN ["flutter", "drive", "--driver=app/integration_test_driver/test_driver.dart", "--target=app/integration_test/app_test.dart"]

CMD ["flutter", "run", "app/lib/main/main.dart", "--release"]

EXPOSE 8080
