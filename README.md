# 도담도담 - 스마트 학교 관리 서비스

- 대구소프트웨어마이스터고등학교의 개발 동아리인 B1ND팀에서 개발한 스마트 학교 관리 서비스입니다. </br>
- 다운로드 : [App Store 링크](https://dodam.b1nd.com/ios)

## 미리보기
<p align="center" width="100%">
<img width="18.9%" src = "https://github.com/Team-B1ND/dodamdodam-ios/assets/104059751/cee5d941-8fc9-46b0-8669-af645a0f3da5">
<img width="18.9%" src = "https://github.com/Team-B1ND/dodamdodam-ios/assets/104059751/0dfc7931-6826-401f-a336-2dd03e2f8b02">
<img width="18.9%" src = "https://github.com/Team-B1ND/dodamdodam-ios/assets/104059751/7c867629-7865-4a3c-8b59-3e5d234388b3">
<img width="18.9%" src = "https://github.com/Team-B1ND/dodamdodam-ios/assets/104059751/38392348-0a1f-48c6-b851-3714df827d71">
<img width="18.9%" src = "https://github.com/Team-B1ND/dodamdodam-ios/assets/104059751/f6d39ab4-9cda-4956-b9ef-c8a2bab9bc5a">
</p>

## 프로젝트 실행 및 배포
### 프로젝트 설정
1. [mise](https://mise.jdx.dev/getting-started.html)를 설치 (Tuist 설치 및 실행에 사용됩니다.)
2. 최상위 폴더에서 `make generate` 명령어를 실행 ([Makefile](https://github.com/Team-B1ND/dodamdodam-ios/blob/develop/Makefile)에서 명령어를 확인할 수 있습니다.)

### 프로젝트 실행
1. `DodamDodam` 및 `DodamDodamWidget`타겟의 `Provisioning Profile`을 디버그용 파일로 설정
    - 설정 위치: `TargetName > Signing & Capabilities > Signing > Provisioning Profile`
    - 파일 이름: `Dodam_debug.mobileprovision`, `Dodam_widget_debug.mobileprovision`
### 프로젝트 배포
1. `DodamDodam` 및 `DodamDodamWidget`타겟의 `Provisioning Profile`을 릴리즈용 파일로 설정
    - 설정 위치: `TargetName > Signing & Capabilities > Signing > Provisioning Profile`
    - 파일 이름: `Dodam_release.mobileprovision`, `Dodam_widget_release.mobileprovision`
2. `Product > Archive`를 클릭하여 프로젝트를 빌드
3. `Distribute App > App Store Connect`를 클릭하여 업로드
